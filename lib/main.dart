import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
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
=======
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/nav_wiget.dart';

void main() {
  runApp(
    DevicePreview(enabled: kDebugMode, builder: (context) => const MyApp()),
>>>>>>> new-api
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evelyn Unmech Cafè',
<<<<<<< HEAD
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
=======

      useInheritedMediaQuery: true,
      builder: (context, child) {
        return DevicePreview.appBuilder(context, child);
      },

      // builder: DevicePreview.appBuilder,
>>>>>>> new-api
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
<<<<<<< HEAD
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const NavWiget(),
      },
=======

      home: NavWiget(),
>>>>>>> new-api
    );
  }
}
