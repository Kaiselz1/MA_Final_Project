import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/screens/cart_screen.dart';
import 'package:pos_lab/screens/category_screen.dart';
import 'package:pos_lab/screens/favorite_screen.dart';
import 'package:pos_lab/screens/history_screen.dart';
import 'package:pos_lab/screens/home_screen.dart';
import 'package:pos_lab/style/color.dart';

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
    final Color navBarBackground = isDark ? AppColor.col7 : Colors.white;

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeScreen(),
            CartScreen(),
            HistoryScreen(),
            FavoriteScreen(),
            CategoryScreen(),
          ],
        );
      }),
      
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
            onTap: controller.onChanged,
            type: BottomNavigationBarType.fixed,
            backgroundColor: navBarBackground,
            elevation: 0, // Set elevation to 0 since we are using custom Container shadow
            selectedItemColor: activeColor,
            unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
            selectedIconTheme: IconThemeData(
              size: 28, 
              color: activeColor,
            ),
            unselectedIconTheme: const IconThemeData(
              size: 22, 
            ),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                activeIcon: Icon(CupertinoIcons.house_fill),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart),
                activeIcon: Icon(CupertinoIcons.cart_fill),
                label: 'Ordered',
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
      ),
    );
  }
}