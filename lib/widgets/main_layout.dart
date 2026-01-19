import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/screens/category_screen.dart';
import 'package:pos_lab/screens/setting_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/header_widget.dart';
import 'package:pos_lab/widgets/search_widget.dart'; // Ensure this import exists
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/repositories/user_repo.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();

    return Scaffold(
      backgroundColor: AppColor.col8,
      body: Column(
        children: [
          // Header only
          AppHeader(
            name: ValueListenableBuilder<UserProfile?>(
              valueListenable: UserRepo.profileNotifier,
              builder: (_, user, __) => Text(user?.name ?? "Admin"),
            ),
            email: ValueListenableBuilder<UserProfile?>(
              valueListenable: UserRepo.profileNotifier,
              builder: (_, user, __) =>
                  Text(user?.email ?? "guest@example.com"),
            ),
            onMenuTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (_, __, ___) => const SettingScreen(),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position:
                          Tween(begin: const Offset(-1, 0), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeOutCubic))
                              .animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),

          // No search bar spacer needed now

          // Content fills remaining space
          Expanded(child: child),
        ],
      ),
    );
  }
}
