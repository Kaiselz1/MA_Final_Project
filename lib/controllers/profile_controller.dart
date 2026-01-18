import 'package:flutter/material.dart';
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/ui_state/ui_status.dart';
import 'package:pos_lab/api/api_base_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  UIStatus _status = UIStatus.idle;
  String? _errorMessage;
  UserProfile? _profile;

  UIStatus get status => _status;
  String? get errorMessage => _errorMessage;
  UserProfile get profile =>
      _profile ?? UserProfile(name: '', email: '', phone: '', address: '');

  ProfileController() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        _errorMessage = "No authentication token found";
        return;
      }

      final response = await http.get(
        Uri.parse('${ApiBaseUrl.baseUrl}/auth/profile'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _profile = UserProfile.fromJson(data);
      } else {
        _errorMessage = "Failed to load profile";
      }
    } catch (e) {
      _errorMessage = "Error loading profile: $e";
    }
  }

  Future<void> saveProfile(UserProfile profile) async {
    _status = UIStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        _status = UIStatus.error;
        _errorMessage = "No authentication token found";
        notifyListeners();
        return;
      }

      final response = await http.put(
        Uri.parse('${ApiBaseUrl.baseUrl}/auth/profile'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'name': profile.name,
          'email': profile.email,
          'phone': profile.phone,
          'address': profile.address,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _profile = UserProfile.fromJson(data);
        _status = UIStatus.success;
      } else {
        final error = jsonDecode(response.body);
        _status = UIStatus.error;
        _errorMessage = error['detail'] ?? 'Failed to update profile';
      }
    } catch (e) {
      _status = UIStatus.error;
      _errorMessage = 'Error updating profile: $e';
    }

    notifyListeners();
  }

  void resetStatus() {
    _status = UIStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }
}
