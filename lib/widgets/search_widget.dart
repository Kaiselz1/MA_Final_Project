import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/style/color.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String)? onSearchChanged;
  final VoidCallback? onCategoryTap;
  final double top;

  const SearchBarWidget({
    super.key,
    this.onSearchChanged,
    this.onCategoryTap,
    this.top = 110,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Detect Dark Mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor = isDark ? AppColor.col7 : Colors.white;
    final Color primaryIconColor = isDark ? AppColor.col4 : AppColor.col5;
    final Color textColor = isDark ? Colors.white70 : Colors.black54;

    return Positioned(
      top: top,
      left: 20,
      right: 20,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: isDark ? Border.all(color: Colors.white10) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.15),
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: TextField(
          onChanged: onSearchChanged,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            icon: Icon(Icons.search, size: 30, color: primaryIconColor),
            hintText: 'Search drink',
            hintStyle: TextStyle(color: textColor),
            border: InputBorder.none,
            suffixIcon: IconButton(
              iconSize: 25,
              padding: EdgeInsets.zero,
              onPressed:
                  onCategoryTap ??
                  () {
                    Get.find<MainController>().currentIndex.value = 4;
                  },
              icon: SvgPicture.asset(
                'assets/icons/category.svg',
                width: 25,
                height: 25,
                color: primaryIconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
