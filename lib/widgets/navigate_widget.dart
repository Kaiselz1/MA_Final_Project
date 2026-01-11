import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_lab/style/color.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(CupertinoIcons.house_fill, 0),
          _navItem(CupertinoIcons.cart_fill, 1),
          _navItem(CupertinoIcons.clock_fill, 2),
          _navItem(CupertinoIcons.heart_fill, 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedScale(
        scale: isActive ? 1.3 : 1.0, // active icon grows
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Icon(
          icon,
          size: 23, // base size
          color: isActive ? AppColor.col5 : Colors.black26,
        ),
      ),
    );
  }
}
