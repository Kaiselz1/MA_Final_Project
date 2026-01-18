import 'package:flutter/material.dart';
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/repositories/user_repo.dart';
import 'package:pos_lab/ui_state/ui_status.dart';

class ProfileController extends ChangeNotifier {
  UIStatus status = UIStatus.idle;
  String? errorMessage;

  UserProfile get profile => UserRepo.profile;

  Future<void> saveProfile(UserProfile profile) async {
    try {
      status = UIStatus.loading;
      notifyListeners();

      await UserRepo.updateProfile(profile);

      status = UIStatus.success;
      notifyListeners();
    } catch (_) {
      status = UIStatus.error;
      errorMessage = "Failed to update profile";
      notifyListeners();
    }
  }

  void resetStatus() {
    status = UIStatus.idle;
    errorMessage = null;
  }
}
