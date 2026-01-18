import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/main_controller.dart';
<<<<<<< HEAD
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/models/user_profile.dart';
import 'package:pos_lab/repositories/user_repo.dart';
=======
import 'package:pos_lab/models/category.dart';
import 'package:pos_lab/models/product.dart';
>>>>>>> new-api
import 'package:pos_lab/screens/setting_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/category_card.dart';
import 'package:pos_lab/widgets/header_widget.dart';
<<<<<<< HEAD
=======
import 'package:pos_lab/api/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
>>>>>>> new-api

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  Set<int> favoriteIds = {};
  String _selectedCategoryPath = "category";
<<<<<<< HEAD

  final List<Map<String, String>> categoryData = [
    {"name": "Iced Coffee", "icon": "assets/icons/iced_coffee.svg"},
    {"name": "Hot Coffee", "icon": "assets/icons/hot_coffee.svg"},
    {"name": "Hot Drink", "icon": "assets/icons/hot_drink.svg"},
    {"name": "Iced Drink", "icon": "assets/icons/iced_drink.svg"},
    {"name": "Frappuccino", "icon": "assets/icons/frappuccino.svg"},
    {
      "name": "Food & Snacks",
      "icon": "assets/icons/food_snack.svg",
    }, // Name matches ProductRepo
  ];
=======
  bool isLoading = true;
  List<Category> categories = [];

  // List<Category> categories = [
  //   {"name": "Iced Coffee", "icon": "assets/icons/iced_coffee.svg"},
  //   {"name": "Hot Coffee", "icon": "assets/icons/hot_coffee.svg"},
  //   {"name": "Hot Drink", "icon": "assets/icons/hot_drink.svg"},
  //   {"name": "Iced Drink", "icon": "assets/icons/iced_drink.svg"},
  //   {"name": "Frappuccino", "icon": "assets/icons/frappuccino.svg"},
  //   {
  //     "name": "Food & Snacks",
  //     "icon": "assets/icons/food_snack.svg",
  //   }, // Name matches ProductRepo
  // ];
>>>>>>> new-api

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
<<<<<<< HEAD
=======
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.baseUrl + ApiUrl.categories),
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
>>>>>>> new-api
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.col8,

      body: Stack(
        children: [
          Column(
            children: [
              // ================= HEADER =================
              AppHeader(
<<<<<<< HEAD
                name: ValueListenableBuilder<UserProfile>(
                  valueListenable: UserRepo.profileNotifier,
                  builder: (_, user, __) => Text(user.name),
                ),
                email: ValueListenableBuilder<UserProfile>(
                  valueListenable: UserRepo.profileNotifier,
                  builder: (_, user, __) => Text(user.email),
                ),
=======
                name: 'John Noon',
                email: 'johnnoon77@gmail.com',
>>>>>>> new-api
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
                                .easeOutCubic; // Smooth decelerating curve

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
<<<<<<< HEAD
                  itemCount: categoryData.length,
=======
                  itemCount: categories.length,
>>>>>>> new-api
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
<<<<<<< HEAD
                    return CategoryCard(
                      title: categoryData[index]['name']!,
                      iconPath: categoryData[index]['icon']!,
=======
                    final category = categories[index];
                    return CategoryCard(
                      title: category.name,
                      iconPath: category.imageUrl,
>>>>>>> new-api
                      onTap: () {
                        // Navigate to a filtered product list based on categoryData[index]['name']
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
