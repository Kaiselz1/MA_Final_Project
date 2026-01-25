import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pos_lab/controllers/category_controller.dart';
import 'package:pos_lab/controllers/counter_controller.dart';
import 'package:pos_lab/controllers/favorite_controller.dart';
import 'package:pos_lab/controllers/product_controller.dart';
import 'package:pos_lab/controllers/setting_controller.dart';

import 'package:pos_lab/screens/login_screen.dart';
import 'package:pos_lab/screens/register_screen.dart';
import 'package:pos_lab/screens/splash_screen.dart';
import 'package:pos_lab/screens/transaction_history_screen.dart';
import 'package:pos_lab/widgets/nav_wiget.dart';

import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/utils/translate.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await GetStorage.init();

      // Inject controllers ONCE (global)
      Get.put(SettingController(), permanent: true);
      Get.put(ProductController(), permanent: true);
      Get.put(CategoryController(), permanent: true);
      Get.put(FavoriteController(), permanent: true);
      Get.put(CounterController(), permanent: true);

      runApp(const MyApp());
    },
    (error, stack) {
      debugPrint("ZONED ERROR: $error");
      debugPrintStack(stackTrace: stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.find<SettingController>();

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Evelyn Unmech Cafè',

        // --------------------
        // Localization
        // --------------------
        translations: Translate(),
        locale: settingController.getLocale,
        fallbackLocale: const Locale('en', 'US'),

        // --------------------
        // Theme
        // --------------------
        themeMode: settingController.isDark ? ThemeMode.dark : ThemeMode.light,

        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppColor.col8,
          primaryColor: AppColor.col4,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey,
            elevation: 0,
            titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
            iconTheme: const IconThemeData(color: Colors.black),
            actionsIconTheme: const IconThemeData(color: Colors.black),
            shape: Border(
              bottom: BorderSide(
                width: 0.65,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
        ),

        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColor.col7,
          primaryColor: AppColor.col5,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.col7,
            elevation: 0,
            titleTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
            iconTheme: const IconThemeData(color: Colors.white),
            actionsIconTheme: const IconThemeData(color: Colors.white),
            shape: Border(
              bottom: BorderSide(
                width: 0.65,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
        ),

        // --------------------
        // Navigation
        // --------------------
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/home': (_) => const NavWiget(),
          '/transactions': (_) => const TransactionHistoryScreen(),
        },
      );
    });
  }
}
