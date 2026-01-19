import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/category_controller.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/screens/setting_screen.dart';
import 'package:pos_lab/models/category.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/category_card.dart';
import 'package:pos_lab/widgets/header_widget.dart';
import 'package:pos_lab/widgets/main_layout.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _selectedCategoryPath = "category";
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          Column(
            children: [
              // ================= HEADER =================
              AppHeader(
                name: 'John Noon',
                email: 'johnnoon77@gmail.com',
                onMenuTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SettingScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(-1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves
                                .easeOutCubic;

                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                showSearchBar: false,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Get.find<MainController>().currentIndex.value = 0;
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
                      child: const Text(
                        "home",
                        style: TextStyle(color: Colors.black45, fontSize: 16),
                      ),
                    ),
                    Text(
                      " / ",
                      style: TextStyle(color: Colors.black45, fontSize: 16),
                    ),
                    Text(
                      _selectedCategoryPath,
                      style: TextStyle(
                        color: AppColor.col5,
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
                  itemCount: categoryData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      title: categoryData[index]['name']!,
                      iconPath: categoryData[index]['icon']!,
                      onTap: () {},
                    );
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
                  child: const Text(
                    "home",
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                  ),
                ),
                Text(
                  " / ",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
                Text(
                  _selectedCategoryPath,
                  style: TextStyle(
                    color: AppColor.col5,
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
                  title: category.name,
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
  }
}
