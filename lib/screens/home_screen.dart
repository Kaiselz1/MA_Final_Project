import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/api/api_url.dart';
import 'package:pos_lab/controllers/counter_controller.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/screens/category_screen.dart';
import 'package:pos_lab/screens/product_detail_screen.dart';
import 'package:pos_lab/screens/setting_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/header_widget.dart';
import 'package:pos_lab/widgets/product_grid_widget.dart';
import 'package:pos_lab/widgets/search_widget.dart';
import 'package:pos_lab/widgets/slider_widget.dart';
import 'package:pos_lab/widgets/suggestion_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<Product> products = [];
  bool isLoading = true;
  Set<int> favoriteIds = {};
  final CounterController counterController = Get.put(CounterController());

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
    if (kDebugMode) {
      print('object');
    }
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.baseUrl + ApiUrl.products),
        headers: {"accept": "application/json"},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          products = data.map((e) => Product.fromJson(e)).toList();
          debugPrint("Grid received ${products.length} products");
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
    super.build(context);

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
              Expanded(
                child: SingleChildScrollView(
                  physics:
                      const BouncingScrollPhysics(), // allow drag scrolling
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= IMAGE SLIDER =================
                      const ImageSlider(
                        images: [
                          'assets/images/sliders/main_slide.png',
                          'assets/images/sliders/slide2.png',
                          'assets/images/sliders/slide3.png',
                          'assets/images/sliders/slide4.png',
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ================= SUGGESTIONS =================
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: SuggestionList(
                          suggestions: products
                              .map((e) => e.name)
                              .toSet()
                              .toList(),
                          onSelected: (categoryId) {
                            print("Selected: $categoryId");
                          },
                        ),
                      ),

                      // ================= PRODUCT GRID =================
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: ProductGrid(
                          products: products,
                          onAdd: (product) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        ),
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
              Navigator.of(
                context,
                rootNavigator: false,
              ).push(MaterialPageRoute(builder: (_) => const CategoryScreen()));
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
