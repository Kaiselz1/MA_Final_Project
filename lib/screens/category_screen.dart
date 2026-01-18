import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/models/category.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/category_card.dart';
import 'package:pos_lab/api/api_base_url.dart';
import 'package:pos_lab/api/api_end_point.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  Set<int> favoriteIds = {};
  String _selectedCategoryPath = "category";
  bool isLoading = true;
  List<Category> categories = [];

  void addToFavorite(Product product) async {
    setState(() {
      if (favoriteIds.contains(product.id)) {
        favoriteIds.remove(product.id);
      } else {
        favoriteIds.add(product.id);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiBaseUrl.baseUrl + ApiEndPoint.categories),
        headers: {"accept": "application/json"},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          categories = data.map((e) => Category.fromJson(e)).toList();
          debugPrint("Grid received ${categories.length} categories");
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("API error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.col8,

      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
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

              // ================= Body =================
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      title: category.name,
                      iconPath: category.imageUrl,
                      onTap: () {
                        // Update selected category
                        ProductRepo.selectedCategory.value = category.name;
                        // Go back to home screen
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
