import 'package:flutter/material.dart';
import 'package:pos_lab/models/user_profile.dart';

class UserRepo {
  static final ValueNotifier<UserProfile> profileNotifier =
      ValueNotifier<UserProfile>(
        const UserProfile(
          name: "John Noon",
          email: "johnnoon77@gmail.com",
          phone: "095445770",
          address:
              "No.77, St Lum, Stueng Mean Chey 1, Meanchey, Phnom Penh",
        ),
      );

  static UserProfile get profile => profileNotifier.value;

  static Future<void> updateProfile(UserProfile newProfile) async {
    profileNotifier.value = newProfile;
  }
}
