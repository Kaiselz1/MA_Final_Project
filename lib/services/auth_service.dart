import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pos_lab/api/api_base_url.dart';

class AuthService {
  static const String baseUrl = ApiBaseUrl.baseUrl;

  // Debug mode credentials
  static const String debugEmail = 'admin';
  static const String debugPassword = 'admin';

  // Get stored token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Save token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Delete token
  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  // Check if user is authenticated
  static Future<bool> isUserAuthenticated() async {
    try {
      final token = await getToken();

      if (token == null || token.isEmpty) {
        return false;
      }

      // Check if it's a debug token
      if (token == 'DEBUG_MODE_TOKEN') {
        return true;
      }

      // Validate token with backend
      final response = await http
          .get(
            Uri.parse('$baseUrl/auth/validate-token'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['valid'] == true;
      }

      return false;
    } catch (e) {
      print('Authentication check error: $e');
      return false;
    }
  }

  // Login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      // Debug mode check (only in debug mode)
      if (kDebugMode && email == debugEmail && password == debugPassword) {
        await saveToken('DEBUG_MODE_TOKEN');
        return {
          'success': true,
          'message': 'Debug login successful',
          'isDebugMode': true,
        };
      }

      // Regular API login
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/login'),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: {'username': email, 'password': password},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await saveToken(data['access_token']);
        return {
          'success': true,
          'message': 'Login successful',
          'isDebugMode': false,
        };
      } else {
        final error = json.decode(response.body);
        return {'success': false, 'message': error['detail'] ?? 'Login failed'};
      }
    } catch (e) {
      print('Login error: $e');
      return {
        'success': false,
        'message': 'Network error. Please check your connection.',
      };
    }
  }

  // Register
  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'username': username,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Registration successful! Please login.',
        };
      } else {
        final error = json.decode(response.body);
        return {
          'success': false,
          'message': error['detail'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      print('Registration error: $e');
      return {
        'success': false,
        'message': 'Network error. Please check your connection.',
      };
    }
  }

  // Logout
  static Future<void> logout() async {
    try {
      final token = await getToken();

      // If debug token, just delete it
      if (token == 'DEBUG_MODE_TOKEN') {
        await deleteToken();
        return;
      }

      if (token != null) {
        // Call backend logout endpoint
        await http
            .post(
              Uri.parse('$baseUrl/auth/logout'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
            )
            .timeout(const Duration(seconds: 10));
      }
    } catch (e) {
      print('Logout error: $e');
    } finally {
      // Always delete token locally
      await deleteToken();
    }
  }
}
