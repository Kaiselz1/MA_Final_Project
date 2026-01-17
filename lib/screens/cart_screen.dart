import 'package:flutter/material.dart';
import 'package:pos_lab/controllers/cart_controller.dart';
import 'package:pos_lab/dialogs/error_dialog.dart';
import 'package:pos_lab/dialogs/loading_dialog.dart';
import 'package:pos_lab/dialogs/success_dialog.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/ui_state/ui_status.dart';
import 'package:pos_lab/widgets/header_widget.dart';
import 'package:pos_lab/widgets/cart_item_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  late final CartController controller;
  bool _listenerAttached = false;

  @override
  void initState() {
    super.initState();
    controller = CartController();
    controller.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_listenerAttached) return;
    _listenerAttached = true;

    controller.addListener(() {
      switch (controller.status) {
        case UIStatus.loading:
          showLoading(context);
          controller.resetStatus();
          break;

        case UIStatus.error:
          Navigator.pop(context); // close loading
          showError(context, controller.errorMessage ?? "Unknown error");
          controller.resetStatus();

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

    return Scaffold(
      backgroundColor: AppColor.col8,
      body: Column(
        children: [
          AppHeader(
            name: 'John Noon',
            email: 'johnnoon77@gmail.com',
            onMenuTap: () => controller.openSettings(context),
            showSearchBar: false,
          ),
          const SizedBox(height: 20),

          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: ProductRepo.cartVersion,
              builder: (_, __, ___) {
                final items = controller.items;

                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  child: Column(
                    children: [
                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CartItemTile(
                            item: item,
                            onIncrease: () => controller.increaseQty(item),
                            onDecrease: () => controller.decreaseQty(item),
                            onDelete: () => controller.deleteItem(item),
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
              final isEmpty = controller.items.isEmpty;

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
                          child: const Text(
                            "Clear Cart",
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
                              : () => controller.proceedToCheckout(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.col3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            "Proceed to Checkout",
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
