import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_lab/controllers/category_controller.dart';
import 'package:pos_lab/enum/language.dart';
import 'package:pos_lab/enum/theme_mode.dart';
import 'package:pos_lab/style/color.dart';

class SettingController extends GetxController {
  final box = GetStorage();

  static const _themeKey = 'theme_mode';
  static const _langKey = 'language';

  final themeMode = TThemeMode.light.obs;
  final language = Language.en.obs;

  bool get isDark => themeMode.value == TThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    final savedTheme = box.read(_themeKey);
    final savedLang = box.read(_langKey);

    if (savedTheme is int) {
      themeMode.value = TThemeMode.values[savedTheme];
    }

    if (savedLang is int) {
      language.value = Language.values[savedLang];
    }

    Get.changeTheme(currentTheme);
    Get.updateLocale(getLocale);
  }

  Locale get getLocale {
    return language.value == Language.kh
        ? const Locale('km', 'KH')
        : const Locale('en', 'US');
  }

  ThemeData get currentTheme => isDark ? _darkTheme : _lightTheme;

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.col8,
    primaryColor: AppColor.col4,
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.col7,
    primaryColor: AppColor.col5,
  );

  void toggleTheme(TThemeMode mode) {
    themeMode.value = mode;
    box.write(_themeKey, mode.index);
    Get.changeTheme(currentTheme);
  }

  void changeLanguage(Language lang) {
    language.value = lang;
    box.write(_langKey, lang.index);
    Get.updateLocale(getLocale);

    final categoryCtrl = Get.find<CategoryController>();
    categoryCtrl.categories.clear();
    categoryCtrl.fetchCategories();
  }
}
