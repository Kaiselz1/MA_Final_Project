import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pos_lab/screens/category_screen.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: isDark
              ? Border.all(
                  color: Colors.white12,
                  width: 1,
                )
              : null,
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
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            prefixIcon: Icon(Icons.search, size: 30, color: primaryIconColor),
            hintText: 'search_drink'.tr,
            hintStyle: TextStyle(color: textColor),
            border: InputBorder.none,
            // We use a fixed width container for the suffix to create a large touch target
            suffixIcon: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(() => const CategoryScreen()),
              child: Container(
                width: 50, // This is the invisible clickable width
                height: 50, // Matches search bar height
                alignment: Alignment.center,

                child: SvgPicture.asset(
                  'assets/icons/category.svg',
                  width: 30, // Actual icon size stays small
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    primaryIconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
