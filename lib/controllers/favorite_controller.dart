import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pos_lab/api/api_base_url.dart';
import 'dart:convert';
import 'package:pos_lab/db_helper/favorite_db_service.dart';
import 'package:pos_lab/repositories/user_repo.dart';
import 'package:pos_lab/services/auth_service.dart';

class FavoriteController extends GetxController {
  final RxSet<int> favoriteIds = <int>{}.obs;
  final RxBool isLoading = false.obs;
  final RxBool isSynced = false.obs;

  final String baseUrl = ApiBaseUrl.baseUrl; // Replace with your API URL
  final FavoriteDatabase _db = FavoriteDatabase.instance;

  String? currentUserId;
  String? authToken; // JWT token for authentication

  @override
  void onInit() {
    super.onInit();

    // Listen for profile updates
    UserRepo.profileNotifier.addListener(() {
      _updateUserData();
    });

    // Load token initially
    _loadToken();
  }

  Future<void> _loadToken() async {
    authToken = await AuthService.getToken();

    // If token exists and profile already loaded → load favorites
    if (authToken != null && UserRepo.profile != null) {
      currentUserId = UserRepo.profile!.id.toString();
      loadFavorites();
    }
  }

  void _updateUserData() async {
    final profile = UserRepo.profile;
    if (profile == null) return;

    currentUserId = profile.id.toString();
    authToken = await AuthService.getToken();

    if (authToken != null && currentUserId != null) {
      isSynced.value = false;
      loadFavorites();
    }
  }

  // Get authorization headers
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (authToken != null) 'Authorization': 'Bearer $authToken',
  };

  // Load favorites from local DB first, then sync with server if needed
  Future<void> loadFavorites() async {
    if (currentUserId == null) return;

    try {
      isLoading.value = true;

      // Load from local database first (instant)
      final localFavorites = await _db.getFavorites(currentUserId!);
      favoriteIds.value = localFavorites;

      // Check if we need to sync with server
      if (!isSynced.value) {
        await syncWithServer();
      }
    } catch (e) {
      print('Error loading favorites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Sync with server (only if not already synced)
  Future<void> syncWithServer() async {
    if (currentUserId == null) return;

    try {
      // Use the authenticated endpoint: GET /favorites/
      final response = await http.get(
        Uri.parse('$baseUrl/favorites/'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final serverFavorites = List<int>.from(data['favorites'] ?? []);

        // Update local database with server data
        await _db.syncFromServer(currentUserId!, serverFavorites);

        // Update in-memory state
        favoriteIds.value = serverFavorites.toSet();
        isSynced.value = true;
      } else if (response.statusCode == 401) {
        print('Authentication failed. Please login again.');
        // Handle authentication error
      }
    } catch (e) {
      print('Error syncing with server: $e');
      // Continue with local data if sync fails
    }
  }

  // Toggle favorite
  Future<void> toggleFavorite(int productId) async {
    if (currentUserId == null) return;

    try {
      final isFav = favoriteIds.contains(productId);

      if (isFav) {
        // Remove from favorites
        favoriteIds.remove(productId);
        await _db.removeFavorite(currentUserId!, productId);
        await _removeFavoriteOnServer(productId);
      } else {
        // Add to favorites
        favoriteIds.add(productId);
        await _db.addFavorite(currentUserId!, productId);
        await _addFavoriteOnServer(productId);
      }
    } catch (e) {
      print('Error toggling favorite: $e');
      // Revert on error
      await loadFavorites();
    }
  }

  // Add favorite to server
  Future<void> _addFavoriteOnServer(int productId) async {
    if (currentUserId == null) return;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/favorites/'),
        headers: _headers,
        body: json.encode({'product_id': productId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _db.markAsSynced(currentUserId!, [productId]);
      } else if (response.statusCode == 401) {
        print('Authentication failed');
      }
    } catch (e) {
      print('Error adding favorite to server: $e');
      // Keep in local DB, will sync later
    }
  }

  // Remove favorite from server
  Future<void> _removeFavoriteOnServer(int productId) async {
    if (currentUserId == null) return;

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/favorites/$productId'),
        headers: _headers,
      );

      if (response.statusCode == 401) {
        print('Authentication failed');
      }
    } catch (e) {
      print('Error removing favorite from server: $e');
    }
  }

  // Check if product is favorite
  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }

  // Force sync unsynced favorites
  Future<void> syncUnsyncedFavorites() async {
    if (currentUserId == null) return;

    try {
      final unsynced = await _db.getUnsyncedFavorites(currentUserId!);

      for (final productId in unsynced) {
        await _addFavoriteOnServer(productId);
      }
    } catch (e) {
      print('Error syncing unsynced favorites: $e');
    }
  }

  // Clear all favorites
  Future<void> clearAllFavorites() async {
    if (currentUserId == null) return;

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/favorites/'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        await _db.clearUserFavorites(currentUserId!);
        favoriteIds.clear();
      }
    } catch (e) {
      print('Error clearing favorites: $e');
    }
  }

  // Update auth token (call this when user logs in)
  void updateAuthToken(String token, String userId) {
    authToken = token;
    currentUserId = userId;
    isSynced.value = false;
    loadFavorites();
  }

  // Clear on logout
  void clearOnLogout() {
    favoriteIds.clear();
    currentUserId = null;
    authToken = null;
    isSynced.value = false;
  }
}
