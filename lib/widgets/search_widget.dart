import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/screens/category_screen.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String)? onSearchChanged;
  final VoidCallback? onCategoryTap;
  final double top; // allow positioning

  const SearchBarWidget({
    super.key,
    this.onSearchChanged,
    this.onCategoryTap,
    this.top = 110, // default position
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: 20,
      right: 20,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        
        child: TextField(
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            icon: Icon(Icons.search, size: 30, color: AppColor.col5),
            hintText: 'Search drink',
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: onCategoryTap ??
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CategoryScreen()),
                    );
                  },
              icon: SvgPicture.asset(
                'assets/icons/category.svg',
                width: 25,
                height: 25,
                color: AppColor.col5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
