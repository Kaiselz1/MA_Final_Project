import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/screens/login_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/enum/language.dart';
import 'package:pos_lab/enum/theme_mode.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.put(SettingController());

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryBrandColor = isDark ? AppColor.col4 : AppColor.col5;
    Color adaptiveTextColor = isDark ? AppColor.col8 : AppColor.col6;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header Row ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
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
                        Text(
                          "John Noon",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryBrandColor, // DYNAMIC COLOR
                          ),
                        ),
                        Text(
                          "johnnoon77@gmail.com",
                          style: TextStyle(
                            color: adaptiveTextColor.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      size: 40,
                      color: primaryBrandColor,
                    ), // DYNAMIC COLOR
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Edit Profile Button
              _buildButton("edit_profile".tr, primaryBrandColor, () {
                Get.offAll(() => const LoginScreen());
              }),

              const Divider(height: 30),

              // --- Theme Section ---
              Text(
                "Theme".tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryBrandColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Obx(
                () => Column(
                  children: [
                    _buildToggleOption(
                      label: "lightMode".tr,
                      primaryColor: primaryBrandColor,
                      adaptiveTextColor: adaptiveTextColor,
                      isActive: controller.themeMode.value == TThemeMode.light,
                      onChanged: (val) =>
                          controller.toggleTheme(TThemeMode.light),
                    ),
                    _buildToggleOption(
                      label: "darkMode".tr,
                      primaryColor: primaryBrandColor,
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
                  color: primaryBrandColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Obx(
                () => Column(
                  children: [
                    _buildToggleOption(
                      label: "english".tr,
                      primaryColor: primaryBrandColor,
                      adaptiveTextColor: adaptiveTextColor,
                      isActive: controller.language.value == Language.en,
                      onChanged: (val) => controller.toggleLanguage(
                        Language.en,
                      ), // Changed to toggle
                    ),
                    _buildToggleOption(
                      label: "khmer".tr,
                      primaryColor: primaryBrandColor,
                      adaptiveTextColor: adaptiveTextColor,
                      isActive: controller.language.value == Language.kh,
                      onChanged: (val) => controller.toggleLanguage(
                        Language.kh,
                      ), // Changed to toggle
                    ),
                  ],
                ),
              ),

              const Divider(height: 20),

              _buildContactItem(
                Icons.telegram,
                "095 445 770",
                primaryBrandColor,
                adaptiveTextColor,
              ),
              _buildContactItem(
                Icons.phone,
                "095 445 770",
                primaryBrandColor,
                adaptiveTextColor,
              ),
              _buildContactItem(
                Icons.email,
                "basswalker76@gmail.com",
                primaryBrandColor,
                adaptiveTextColor,
              ),
              _buildContactItem(
                Icons.facebook,
                "Sokphonai Ny",
                primaryBrandColor,
                adaptiveTextColor,
              ),

              const SizedBox(height: 20),

              Center(
                child: _buildButton(
                  "Sign Out".tr,
                  primaryBrandColor,
                  () {
                    Get.offAll(() => const LoginScreen());
                  },
                  width: 200,
                  height: 50,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String label,
    Color color,
    VoidCallback onPressed, {
    double width = 120,
    double height = 30,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
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
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Switch(
            value: isActive,
            onChanged: onChanged,
            // 1. Force the thumb to be a solid color in both states
            thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) return Colors.white;
              return adaptiveTextColor.withOpacity(0.6);
            }),
            // 2. Force the track background color
            trackColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) return primaryColor;
              return adaptiveTextColor.withOpacity(0.1);
            }),
            // 3. REMOVE THE OUTLINE (This is what makes it look different on restart)
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            // 4. PREVENT SIZE JUMPING (Removes the internal M3 icon)
            thumbIcon: WidgetStateProperty.all(
              const Icon(Icons.circle, color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String text,
    Color primaryColor,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: primaryColor.withOpacity(0.1),
            child: Icon(icon, size: 25, color: primaryColor),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
