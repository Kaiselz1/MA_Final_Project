import 'package:flutter/material.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/screens/category_screen.dart';
import 'package:pos_lab/screens/product_detail_screen.dart';
import 'package:pos_lab/screens/setting_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/header_widget.dart';
import 'package:pos_lab/widgets/navigate_widget.dart';
import 'package:pos_lab/widgets/product_grid_widget.dart';
import 'package:pos_lab/widgets/search_widget.dart';
import 'package:pos_lab/widgets/slider_widget.dart';
import 'package:pos_lab/widgets/suggestion_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<int> favoriteIds = {};

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.col8,

      body: Stack(
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
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                child: SuggestionList(
                  suggestions: ProductRepo.products
                      .map((e) => e.name)
                      .toSet()
                      .toList(),
                  onSelected: (category) {
                    print("Selected: $category");
                  },
                ),
              ),

              // ================= Body =================
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ImageSlider(
                        images: [
                          'assets/images/sliders/main_slide.png',
                          'assets/images/sliders/slide2.png',
                          'assets/images/sliders/slide3.png',
                          'assets/images/sliders/slide4.png',
                        ],
                      ),

                      SizedBox(height: 10),
                      // Suggestions
                      ProductGrid(
                        products: ProductRepo.products,
                        onAdd: (product) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SearchBarWidget(
            top: 110,
            onSearchChanged: (value) {
              print("Searching: $value");
            },
            onCategoryTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoryScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
