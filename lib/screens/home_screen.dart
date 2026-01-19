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

  // Product Controller
  final ProductController productController = Get.find<ProductController>();

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
    ProductRepo.selectedCategory.value = null; // show all products
    // fetchProducts();
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
                  physics:
                      const AlwaysScrollableScrollPhysics(), // allow drag scrolling
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= SUGGESTIONS =================
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 20, 10),
                        child: SuggestionList(
                          suggestions: [
                            "All", // add "All" at the start
                            ...productController.products
                                .map((e) => e.categoryName)
                                .toSet()
                                .toList(),
                          ],
                          onSelected: (categoryName) {
                            if (categoryName == "All") {
                              ProductRepo.selectedCategory.value =
                                  null; // show all products
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
                          builder: (_, __, ___) {
                            final filtered =
                                ProductRepo.selectedCategory.value == null
                                ? productController.products
                                : productController.products
                                      .where(
                                        (p) =>
                                            p.categoryName ==
                                            ProductRepo.selectedCategory.value,
                                      )
                                      .toList();

                            if (filtered.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No products in this category",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
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
