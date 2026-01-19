import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/counter_controller.dart';
import 'package:pos_lab/controllers/product_controller.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/screens/product_detail_screen.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/product_grid_widget.dart';
import 'package:pos_lab/widgets/slider_widget.dart';
import 'package:pos_lab/widgets/suggestion_widget.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/controllers/favorite_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<Product> products = [];
  bool isLoading = true;
  final CounterController counterController = Get.put(CounterController());

  // Product Controller
  final ProductController productController = Get.find<ProductController>();

  // Favorite Controller
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  void initState() {
    if (kDebugMode) {
      print('HomeScreen initialized');
    }
    super.initState();
    ProductRepo.selectedCategory.value = null; // show all products

    // Load favorites when screen initializes
    favoriteController.loadFavorites();
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
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= SUGGESTIONS =================
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 20, 10),
                        child: SuggestionList(
                          suggestions: [
                            "All",
                            "Favorites", // Add Favorites category
                            ...productController.products
                                .map((e) => e.categoryName)
                                .toSet()
                                .toList(),
                          ],
                          onSelected: (categoryName) {
                            if (categoryName == "All") {
                              ProductRepo.selectedCategory.value = null;
                            } else if (categoryName == "Favorites") {
                              ProductRepo.selectedCategory.value = "Favorites";
                            } else {
                              ProductRepo.selectedCategory.value = categoryName;
                            }
                          },
                        ),
                      ),

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

                      // ================= PRODUCT GRID =================
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: ValueListenableBuilder<String?>(
                          valueListenable: ProductRepo.selectedCategory,
                          builder: (_, selectedCategory, ___) {
                            return Obx(() {
                              List<Product> filtered;

                              if (selectedCategory == null) {
                                // Show all products
                                filtered = productController.products;
                              } else if (selectedCategory == "Favorites") {
                                // Show only favorite products
                                filtered = productController.products
                                    .where(
                                      (p) =>
                                          favoriteController.isFavorite(p.id),
                                    )
                                    .toList();
                              } else {
                                // Filter by category
                                filtered = productController.products
                                    .where(
                                      (p) => p.categoryName == selectedCategory,
                                    )
                                    .toList();
                              }

                              if (filtered.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          selectedCategory == "Favorites"
                                              ? Icons.favorite_border
                                              : Icons.inventory_2_outlined,
                                          size: 64,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          selectedCategory == "Favorites"
                                              ? "No favorite products yet"
                                              : "No products in this category",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              return ProductGrid(
                                products: filtered,
                                onAdd: (product) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ProductDetailScreen(product: product),
                                    ),
                                  );
                                },
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
