import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pos_lab/screens/login_screen.dart';

void main() {
  runApp(
    DevicePreview(enabled: kDebugMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
      builder: (context, child) => DevicePreview.appBuilder(context, child),
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tripsans',
        useMaterial3: false,
        appBarTheme: AppBarThemeData(
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
    );
  }
}
