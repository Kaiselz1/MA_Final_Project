import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/enum/language.dart';
import 'package:pos_lab/enum/theme_mode.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/utils/translate.dart';
import 'package:pos_lab/widgets/nav_wiget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    DevicePreview(enabled: kDebugMode, builder: (context) => const MyApp()),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final SettingController settingController = Get.put(
//       SettingController(),
//       permanent: true,
//     );
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Evelyn Unmech Cafè',

//       useInheritedMediaQuery: true,
//       builder: DevicePreview.appBuilder,

//       translations: Translate(),
//       locale: settingController.language.value == Language.en
//           ? const Locale('en')
//           : const Locale('km'),
//       // theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       themeMode: settingController.themeMode.value == TThemeMode.dark
//           ? ThemeMode.dark
//           : ThemeMode.light,

//       theme: ThemeData(
//         brightness: Brightness.light,
//         fontFamily: 'Tripsans',
//         primaryColor: AppColor.col4,
//         useMaterial3: false,

//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           titleTextStyle: TextStyle(fontSize: 16, color: Colors.black),
//           iconTheme: IconThemeData(color: Colors.black),
//           actionsIconTheme: IconThemeData(color: Colors.black),
//           shape: LinearBorder.bottom(
//             side: BorderSide(
//               width: 0.65,
//               color: Colors.black.withValues(alpha: 0.1),
//             ),
//           ),
//         ),
//       ),

//       home: NavWiget(),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingController settingController = Get.put(
      SettingController(),
      permanent: true,
    );

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Evelyn Unmech Cafè',

        useInheritedMediaQuery: true,
        builder: DevicePreview.appBuilder,

        translations: Translate(),

        // 3. Bind the observable values
        locale: settingController.language.value == Language.en
            ? const Locale('en')
            : const Locale('km'),

        themeMode: settingController.themeMode.value == TThemeMode.dark
            ? ThemeMode.dark
            : ThemeMode.light,

        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          primaryColor: AppColor.col5,
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(AppColor.col5),
            trackColor: MaterialStateProperty.all(
              AppColor.col5.withOpacity(0.3),
            ),
          ),
        ),

        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          primaryColor: AppColor.col4,
          scaffoldBackgroundColor: AppColor.col7,

          colorScheme: ColorScheme.dark(
            primary: AppColor.col4,
            surface: AppColor.col7,
            background: AppColor.col7,
          ),
        ),

        home: const NavWiget(),
      );
    });
  }
}
