import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_lab/screens/cart_screen.dart';
import 'package:pos_lab/screens/favorite_screen.dart';
import 'package:pos_lab/screens/history_screen.dart';
import 'package:pos_lab/screens/home_screen.dart';
import 'package:pos_lab/style/color.dart';

class NavWiget extends StatefulWidget {
  const NavWiget({Key? key}) : super(key: key);

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavWiget> {
  int _selectedIndex = 0;

  void _navigateButtonBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    CartScreen(),
    HistoryScreen(),
    FavoriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateButtonBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.col5,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(
          size: 25,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 20,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0
                  ? CupertinoIcons.house_fill
                  : CupertinoIcons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1
                  ? CupertinoIcons.cart_fill
                  : CupertinoIcons.cart,
            ),
            label: 'Ordered',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2
                  ? CupertinoIcons.clock_fill
                  : CupertinoIcons.clock,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3
                  ? CupertinoIcons.heart_fill
                  : CupertinoIcons.heart,
            ),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
