import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
import 'package:pos_lab/screens/splash_screen.dart';
import 'package:pos_lab/screens/login_screen.dart';
import 'package:pos_lab/screens/register_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/nav_wiget.dart';
import 'dart:async';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  runZonedGuarded(
    () {
      runApp(
        DevicePreview(
          enabled: !kReleaseMode, // Only enable in debug/profile mode
          builder: (context) => const MyApp(),
        ),
      );
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evelyn Unmech Cafè',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        fontFamily: 'Tripsans',
        primaryColor: AppColor.col4,
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
          iconTheme: const IconThemeData(color: Colors.black),
          actionsIconTheme: const IconThemeData(color: Colors.black),
          shape: LinearBorder.bottom(
            side: BorderSide(
              width: 0.65,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const NavWiget(),
      },
    );
  }
}
