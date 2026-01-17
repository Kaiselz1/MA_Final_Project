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
    return Scaffold(
      // body: Obx(
      //   () => Navigator(
      //     onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => IndexedStack(
      //         index: controller.currentIndex.value,
      //         children: [
      //           HomeScreen(),
      //           CartScreen(),
      //           HistoryScreen(),
      //           FavoriteScreen(),
      //           CategoryScreen()
      //         ],
      //       ),),
      //   ),
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
      //   bottomNavigationBar: Obx(
      //     () => BottomNavigationBar(
      //       currentIndex: controller.currentIndex.value > 3
      //           ? 0
      //           : controller.currentIndex.value,
      //       onTap: controller.onChanged,
      //       type: BottomNavigationBarType.fixed,
      //       selectedItemColor: AppColor.col5,
      //       unselectedItemColor: Colors.grey,
      //       selectedIconTheme: const IconThemeData(size: 25),
      //       unselectedIconTheme: const IconThemeData(size: 20),
      //       selectedLabelStyle: const TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 14,
      //       ),
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: Icon(CupertinoIcons.home),
      //           activeIcon: Icon(CupertinoIcons.house_fill),

      //           label: 'Home',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(CupertinoIcons.cart),
      //           activeIcon: Icon(CupertinoIcons.cart_fill),
      //           label: 'Ordered',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(CupertinoIcons.clock),
      //           activeIcon: Icon(CupertinoIcons.clock_fill),
      //           label: 'History',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(CupertinoIcons.heart),
      //           activeIcon: Icon(CupertinoIcons.heart_fill),
      //           label: 'Favorite',
      //         ),
      //       ],
      //     ),
      //   ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.onChanged,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.col5,
          unselectedItemColor: Colors.grey,
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
        );
      }),
    );
  }
}
