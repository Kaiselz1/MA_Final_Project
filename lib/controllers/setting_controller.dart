import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_lab/enum/language.dart';
import 'package:pos_lab/enum/theme_mode.dart';
import 'package:pos_lab/style/color.dart';

class SettingController extends GetxController {
  final box = GetStorage();

  var themeMode = TThemeMode.light.obs;
  var language = Language.en.obs;

  bool get isDark => themeMode.value == TThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void changeTheme(TThemeMode theme) {
    themeMode.value = theme;

    if (theme == TThemeMode.dark) {
      Get.changeTheme(
        ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColor.col7, // Dark Background
          primaryColor: AppColor.col5,
          dividerColor: Colors.white24,
        ),
      );
    } else {
      Get.changeTheme(
        ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppColor.col8, // Light Background
          primaryColor: AppColor.col4,
          dividerColor: Colors.black12,
        ),
      );
    }

    // Save to local storage
    box.write('themeMode', theme.index);
  }

  void changeLanguage(Language lang) {
    language.value = lang;
    switch (lang) {
      case Language.en:
        Get.updateLocale(const Locale('en', 'US'));
        break;
      case Language.kh:
        Get.updateLocale(const Locale('km', 'KH'));
        break;
    }
    box.write('language', lang.index);
  }

  void _loadSettings() {
    final savedThemeIndex = box.read('themeMode');
    final savedLangIndex = box.read('language');

    if (savedThemeIndex != null) {
      themeMode.value = TThemeMode.values[savedThemeIndex];
      // Apply the theme immediately on load
      changeTheme(themeMode.value);
    }

    if (savedLangIndex != null) {
      language.value = Language.values[savedLangIndex];
      // Apply the locale immediately on load
      changeLanguage(language.value);
    }
  }

  void toggleTheme(TThemeMode selectedTheme) {
    if (themeMode.value == selectedTheme) {
      // If clicking the active one, flip to the other
      changeTheme(
        selectedTheme == TThemeMode.dark ? TThemeMode.light : TThemeMode.dark,
      );
    } else {
      changeTheme(selectedTheme);
    }
  }

  void toggleLanguage(Language selectedLang) {
    if (language.value == selectedLang) {
      // If clicking the active one, flip to the other
      changeLanguage(selectedLang == Language.en ? Language.kh : Language.en);
    } else {
      changeLanguage(selectedLang);
    }
  }
}
