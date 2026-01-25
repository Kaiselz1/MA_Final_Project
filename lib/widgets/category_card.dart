import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
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
    final SettingController controller = Get.find<SettingController>();
    return Obx(() {
      final bool isDark = controller.isDark;

      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColor.col6 : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: isDark
                ? Border.all(
                    color: AppColor.col4.withValues(alpha: 0.2),
                    width: 2.0,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )
                : Border.all(color: Colors.transparent, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black45 : Colors.black26,
                blurRadius: isDark ? 4 : 2,
                offset: isDark ? Offset(4, 4) : Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.network(
                iconPath,
                height: 80,
                width: 80,
                colorFilter: ColorFilter.mode(
                  isDark ? AppColor.col4 : AppColor.col5,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColor.col4 : AppColor.col5,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
