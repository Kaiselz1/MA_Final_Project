import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/enum/language.dart';
import 'package:pos_lab/enum/theme_mode.dart';
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/repositories/user_repo.dart';
import 'package:pos_lab/screens/edit_profile_screen.dart';
import 'package:pos_lab/screens/login_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/services/auth_service.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.find<SettingController>();

    return Obx(() {
      final bool currentIsDark = controller.isDark;
      final Color primaryChange = currentIsDark ? AppColor.col4 : AppColor.col5;
      final Color scaffoldColor = currentIsDark ? AppColor.col7 : AppColor.col8;
      final adaptiveTextColor = currentIsDark ? AppColor.col8 : AppColor.col6;

      return Scaffold(
        backgroundColor: scaffoldColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/profiles/johnnoon.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          ValueListenableBuilder<UserProfile?>(
                            valueListenable: UserRepo.profileNotifier,
                            builder: (_, user, __) {
                              if (user == null) {
                                return Text(
                                  "Admin",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryChange,
                                  ),
                                );
                              }

                              return Text(
                                user.name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.col5,
                                ),
                              );
                            },
                          ),

                          ValueListenableBuilder<UserProfile?>(
                            valueListenable: UserRepo.profileNotifier,
                            builder: (_, user, __) {
                              if (user == null) {
                                return Text(
                                  "guest@example.com",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                );
                              }

                              return Text(
                                user.email,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, size: 40, color: primaryChange),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 130,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryChange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      "edit_profile".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 30),

                Text(
                  "Theme".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryChange,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => Column(
                    children: [
                      _buildToggleOption(
                        label: "lightMode".tr,
                        primaryColor: primaryChange,
                        adaptiveTextColor: adaptiveTextColor,
                        isActive:
                            controller.themeMode.value == TThemeMode.light,
                        onChanged: (val) =>
                            controller.toggleTheme(TThemeMode.light),
                      ),
                      _buildToggleOption(
                        label: "darkMode".tr,
                        primaryColor: primaryChange,
                        adaptiveTextColor: adaptiveTextColor,
                        isActive: controller.themeMode.value == TThemeMode.dark,
                        onChanged: (val) =>
                            controller.toggleTheme(TThemeMode.dark),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 20),

                Text(
                  "language".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryChange,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => Column(
                    children: [
                      _buildToggleOption(
                        label: "english".tr,
                        primaryColor: primaryChange,
                        adaptiveTextColor: adaptiveTextColor,
                        isActive: controller.language.value == Language.en,
                        onChanged: (val) =>
                            controller.changeLanguage(Language.en),
                      ),
                      _buildToggleOption(
                        label: "khmer".tr,
                        primaryColor: primaryChange,
                        adaptiveTextColor: adaptiveTextColor,
                        isActive: controller.language.value == Language.kh,
                        onChanged: (val) =>
                            controller.changeLanguage(Language.kh),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 20),
                Text(
                  "contact".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryChange,
                    fontSize: 18,
                  ),
                ),
                _buildContactSection(currentIsDark, primaryChange),
                const SizedBox(height: 30),

                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        AuthService.logout();
                        AuthService.deleteToken();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryChange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        "sign_out".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildToggleOption({
    required String label,
    required Color primaryColor,
    required Color adaptiveTextColor,
    required bool isActive,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? primaryColor
                  : adaptiveTextColor.withOpacity(0.5),
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          Switch(
            value: isActive,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) return Colors.white;
              return adaptiveTextColor.withOpacity(0.5);
            }),
            trackColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) return primaryColor;
              return adaptiveTextColor.withOpacity(0.1);
            }),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            thumbIcon: WidgetStateProperty.all(
              const Icon(Icons.circle, color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(bool isDark, Color primaryChange) {
    return ValueListenableBuilder<UserProfile?>(
      valueListenable: UserRepo.profileNotifier,
      builder: (_, user, __) {
        return Column(
          children: [
            _buildContactItem(
              Icons.telegram,
              user?.phone ?? "Lor Virakyoth",
              isDark,
              primaryChange,
            ),
            _buildContactItem(
              Icons.phone,
              user?.phone ?? "095 445 770",
              isDark,
              primaryChange,
            ),
            _buildContactItem(
              Icons.email,
              user?.email ?? "taylor67@gmail.com",
              isDark,
              primaryChange,
            ),
            _buildContactItem(
              Icons.facebook,
              user?.name ?? "leap socheat",
              isDark,
              primaryChange,
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String text,
    bool isDark,
    Color primaryChange,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: isDark
                ? Colors.white10
                : Colors.black.withOpacity(0.05),
            child: Icon(icon, size: 23, color: primaryChange),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isDark ? Colors.white54 : AppColor.col5,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
