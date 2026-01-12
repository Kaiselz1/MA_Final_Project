import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_lab/screens/cart_screen.dart';
import 'package:pos_lab/screens/favorite_screen.dart';
import 'package:pos_lab/screens/history_screen.dart';
import 'package:pos_lab/screens/home_screen.dart';
import 'package:pos_lab/style/color.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  int _currentIndex(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name ?? '';

    // Match the route to the correct index
    switch (route) {
      case '/cart':
        return 1;
      case '/history':
        return 2;
      case '/favorite':
        return 3;
      case '/home':
      default:
        return 0;
    }
  }

  void _onTap(BuildContext context, int index) {
    final currentIndex = _currentIndex(context);
    if (index == currentIndex) return;

    Widget screen;
    String routeName;

    switch (index) {
      case 0:
        screen = const HomeScreen();
        routeName = '/home';
        break;
      case 1:
        screen = const CartScreen();
        routeName = '/cart';
        break;
      case 2:
        screen = const HistoryScreen();
        routeName = '/history';
        break;
      case 3:
        screen = const FavoriteScreen();
        routeName = '/favorite';
        break;
      default:
        screen = const HomeScreen();
        routeName = '/home';
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, animation, __, child) {
          final tween = Tween(begin: const Offset(1, 0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColor.col5,
        unselectedItemColor: Colors.black26,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill, size: 26),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart_fill, size: 26),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock_fill, size: 26),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_fill, size: 26),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
