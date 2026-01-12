import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_lab/style/color.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 70,
              width: 70,
              colorFilter: ColorFilter.mode(
                AppColor.col5, 
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColor.col5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}