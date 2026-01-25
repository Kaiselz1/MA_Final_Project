import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/screens/cart_screen.dart';
import 'package:pos_lab/screens/category_screen.dart';
import 'package:pos_lab/screens/favorite_screen.dart';
import 'package:pos_lab/screens/home_screen.dart';
import 'package:pos_lab/screens/transaction_history_screen.dart';
import 'package:pos_lab/screens/setting_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/header_widget.dart';
import 'package:pos_lab/widgets/search_widget.dart'; // Ensure this import exists
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/repositories/user_repo.dart';

// Ensure this import exists
class NavWiget extends StatefulWidget {
  const NavWiget({super.key});

  @override
  State<NavWiget> createState() => _NavWigetState();
}

class _NavWigetState extends State<NavWiget> {
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color activeColor = isDark ? AppColor.col4 : AppColor.col5;
    final Color navBarBackground = isDark ? Colors.black12 : Colors.white;
    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            bool isHome = controller.currentIndex.value == 0;

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                AppHeader(
                  name: ValueListenableBuilder<UserProfile?>(
                    valueListenable: UserRepo.profileNotifier,
                    builder: (_, user, __) {
                      if (user == null) {
                        return const Text("Admin");
                      }
                      return Text(user.name);
                    },
                  ),
                  email: ValueListenableBuilder<UserProfile?>(
                    valueListenable: UserRepo.profileNotifier,
                    builder: (_, user, __) {
                      if (user == null) {
                        return const Text("guest@example.com");
                      }
                      return Text(user.email);
                    },
                  ),
                  onMenuTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SettingScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(-1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeOutCubic;
                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                ),

                if (isHome)
                  Positioned(
                    bottom: -25,
                    left: 20,
                    right: 20,
                    child: SearchBarWidget(
                      onSearchChanged: (value) {
                        print("Searching: $value");
                      },
                      onCategoryTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CategoryScreen(),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          }),

          Obx(
            () => SizedBox(height: controller.currentIndex.value == 0 ? 35 : 0),
          ),

          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  HomeScreen(),
                  CartScreen(),
                  TransactionHistoryScreen(),
                  FavoriteScreen(),
                  CategoryScreen(),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.5)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value > 3
                ? 0
                : controller.currentIndex.value,
            backgroundColor: navBarBackground,
            onTap: controller.onChanged,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: activeColor,
            unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
            selectedIconTheme: IconThemeData(size: 25, color: activeColor),
            unselectedIconTheme: const IconThemeData(size: 20),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                activeIcon: Icon(CupertinoIcons.house_fill),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart),
                activeIcon: Icon(CupertinoIcons.cart_fill),
                label: 'cart'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.clock),
                activeIcon: Icon(CupertinoIcons.clock_fill),
                label: 'history'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart),
                activeIcon: Icon(CupertinoIcons.heart_fill),
                label: 'favorite'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
