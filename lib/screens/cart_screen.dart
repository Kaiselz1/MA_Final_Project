import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_lab/controllers/cart_controller.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/dialogs/error_dialog.dart';
import 'package:pos_lab/dialogs/loading_dialog.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/ui_state/ui_status.dart';
import 'package:pos_lab/widgets/cart_item_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  late final CartController cartController;
  final SettingController settingController = Get.find<SettingController>();

  bool _listenerAttached = false;
  bool isLoading = true;

  final String _selectedCartPath = "add_to_cart";

  @override
  void initState() {
    super.initState();
    cartController = CartController();
    cartController.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_listenerAttached) return;
    _listenerAttached = true;

    cartController.addListener(() {
      switch (cartController.status) {
        case UIStatus.loading:
          showLoading(context);
          cartController.resetStatus();
          break;

        case UIStatus.error:
          Navigator.pop(context); // close loading
          showError(context, cartController.errorMessage ?? "Unknown error");
          cartController.resetStatus();

          break;

        case UIStatus.success:
        case UIStatus.idle:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
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
                    Get.find<MainController>().currentIndex.value = 0;
                    // Navigator.pop(context);
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
                  _selectedCartPath.tr,
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

          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: ProductRepo.cartVersion,
              builder: (_, __, ___) {
                final items = cartController.items;

                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      "your_cart_is_empty".tr,
                      style: TextStyle(
                        color: isDark
                            ? AppColor.col8.withOpacity(0.4)
                            : AppColor.col7.withOpacity(0.4),
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                  child: Column(
                    children: [
                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),

                          child: CartItemTile(
                            item: item,
                            onIncrease: () => cartController.increaseQty(item),
                            onDecrease: () => cartController.decreaseQty(item),
                            onDelete: () => cartController.deleteItem(item),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          ValueListenableBuilder<int>(
            valueListenable: ProductRepo.cartVersion,
            builder: (_, __, ___) {
              final isEmpty = cartController.items.isEmpty;

              return Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          onPressed: isEmpty
                              ? null
                              : () => ProductRepo.clearCart(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.col4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            "clear_cart".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 46,
                        child: ElevatedButton(
                          onPressed: isEmpty
                              ? null
                              : () => cartController.proceedToCheckout(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.col3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            "proceed_to_checkout".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
