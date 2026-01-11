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
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
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
              // Applying the brown color theme seen in Artboard 8
              colorFilter: const ColorFilter.mode(
                Color(0xFF6B4F3F), 
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4F3F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}