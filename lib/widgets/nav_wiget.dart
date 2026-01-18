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

class NavWiget extends StatefulWidget {
  const NavWiget({super.key});

  @override
  State<NavWiget> createState() => _NavWigetState();
}

class _NavWigetState extends State<NavWiget> {
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ================= HEADER & SEARCH BAR AREA =================
          Obx(() {
            bool isHome = controller.currentIndex.value == 0;

            return Stack(
              clipBehavior: Clip.none, // This allows the SearchBar to overlap
              alignment: Alignment.center,
              children: [
                // 1. The Header background
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

                // 2. The Overlapping Search Bar (Home only)
                if (isHome)
                  Positioned(
                    bottom: -25, // Moves it halfway down past the header
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

          // 3. Spacer: Prevents the content from sitting behind the overlapping search bar
          Obx(
            () => SizedBox(height: controller.currentIndex.value == 0 ? 35 : 0),
          ),

          // ================= MAIN CONTENT =================
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.currentIndex.value,
                children: const [
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

      // ================= BOTTOM NAVIGATION =================
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value > 3
              ? 0
              : controller.currentIndex.value,
          onTap: controller.onChanged,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.col5,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(size: 25),
          unselectedIconTheme: const IconThemeData(size: 20),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              activeIcon: Icon(CupertinoIcons.house_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              activeIcon: Icon(CupertinoIcons.cart_fill),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clock),
              activeIcon: Icon(CupertinoIcons.clock_fill),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              activeIcon: Icon(CupertinoIcons.heart_fill),
              label: 'Favorite',
            ),
          ],
        ),
      ),
    );
  }
}
