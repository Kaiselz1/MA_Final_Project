import 'package:flutter/material.dart';
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/api/api_base_url.dart';
import 'package:pos_lab/api/api_end_point.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepo {
  static final ValueNotifier<UserProfile?> profileNotifier =
      ValueNotifier<UserProfile?>(null);

  static UserProfile? get profile => profileNotifier.value;

  static Future<void> loadProfile(String token) async {
    final response = await http.get(
      Uri.parse(ApiBaseUrl.baseUrl + ApiEndPoint.userProfile),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      profileNotifier.value = UserProfile.fromJson(json);
    }
  }

  static Future<void> clear() async {
    profileNotifier.value = null;
  }
}
