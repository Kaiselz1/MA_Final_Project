import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/controllers/product_controller.dart';
import 'package:pos_lab/controllers/favorite_controller.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/screens/product_detail_screen.dart';
import 'package:pos_lab/widgets/product_grid_widget.dart';
import 'package:pos_lab/style/color.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin {
  final ProductController productController = Get.find<ProductController>();
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final SettingController settings = Get.find<SettingController>();
    final String _selectedFavoritePath = "favorite";


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isDark = settings.isDark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
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
                  _selectedFavoritePath.tr,
                  style: TextStyle(
                    color: isDark ? AppColor.col4 : Colors.black45,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Product List
          Expanded(
            child: Obx(() {
              List<Product> favoriteProducts = productController.products
                  .where((p) => favoriteController.isFavorite(p.id))
                  .toList();

              if (favoriteProducts.isEmpty) {
                return Center(child: Text("no_favorites_found".tr));
              }

              return SingleChildScrollView(
                // removePadding ensures the system status bar doesn't add extra gap
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ProductGrid(
                    products: favoriteProducts,
                    onAdd: (product) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
