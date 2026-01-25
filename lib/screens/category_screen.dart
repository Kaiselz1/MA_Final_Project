import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/category_controller.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/category_card.dart';
import 'package:pos_lab/widgets/main_layout.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final String _selectedCategoryPath = "category".tr;
  final CategoryController categoryController = Get.put(CategoryController());
  final SettingController controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isDark = controller.isDark;

      return MainLayout(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<MainController>().currentIndex.value = 0;
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: AppColor.col5,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "home".tr,
                      style: TextStyle(
                        color: isDark ? AppColor.col4 : Colors.black45,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    " / ",
                    style: TextStyle(
                      color: isDark ? AppColor.col4 : Colors.black45,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    _selectedCategoryPath,
                    style: TextStyle(
                      color: isDark ? AppColor.col4 : Colors.black45,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: categoryController.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final category = categoryController.categories[index];
                  return CategoryCard(
                    title: category.name.tr,
                    iconPath: category.imageUrl,
                    onTap: () {
                      ProductRepo.selectedCategory.value = category.name;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
