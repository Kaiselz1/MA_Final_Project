import 'package:flutter/material.dart';
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/repositories/user_repo.dart';
import 'package:pos_lab/ui_state/ui_status.dart';
import 'package:pos_lab/api/api_base_url.dart';
import 'package:pos_lab/api/api_end_point.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  UIStatus _status = UIStatus.idle;
  String? _errorMessage;

  UIStatus get status => _status;
  String? get errorMessage => _errorMessage;

  // Get profile from UserRepo
  UserProfile get profile =>
      UserRepo.profile ??
      UserProfile(name: '', email: '', phone: '', address: '');

  void resetStatus() {
    _status = UIStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> saveProfile(UserProfile updatedProfile) async {
    try {
      _status = UIStatus.loading;
      _errorMessage = null;
      notifyListeners();

      // Get token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        throw Exception('No authentication token found');
      }

      // Send PUT request to update profile
      final response = await http.put(
        Uri.parse(ApiBaseUrl.baseUrl + ApiEndPoint.userProfile),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(updatedProfile.toJson()),
      );

      if (response.statusCode == 200) {
        // Update the local profile in UserRepo
        final json = jsonDecode(response.body);
        UserRepo.profileNotifier.value = UserProfile.fromJson(json);

        _status = UIStatus.success;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Failed to update profile');
      }
    } catch (e) {
      _status = UIStatus.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      notifyListeners();
    }
  }
}
