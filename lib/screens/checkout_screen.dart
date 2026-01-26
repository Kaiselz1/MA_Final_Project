import 'package:flutter/material.dart';
import 'package:pos_lab/api/api_base_url.dart';
import 'package:pos_lab/api/api_end_point.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/controllers/setting_controller.dart';
import 'package:pos_lab/dialogs/success_dialog.dart';
import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/models/transaction.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/header_widget.dart';
import 'package:pos_lab/widgets/cart_item_tile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({
    super.key,
    required this.onBackTap,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
    required this.onConfirmPayment,
  });

  final VoidCallback onBackTap;
  final VoidCallback onConfirmPayment;
  final void Function(CartItem item) onIncrease;
  final void Function(CartItem item) onDecrease;
  final void Function(CartItem item) onDelete;
  final SettingController settingController = Get.find<SettingController>();

  Future<void> createOrderDetail() async {
    try {
      final response = await http.post(
        Uri.parse(ApiBaseUrl.baseUrl + ApiEndPoint.orders),
        headers: {"accept": "application/json"},
      );
      if (response.statusCode == 201) {
        debugPrint("Order detail created successfully.");
      } else {
        debugPrint(
          "Failed to create order detail. Status: ${response.statusCode}",
        );
      }
    } catch (e) {
      debugPrint("API error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          AppTitleHeader(title: 'checkout'.tr, onBackTap: onBackTap),

          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: ProductRepo.cartVersion,
              builder: (_, __, ___) {
                final liveItems = ProductRepo.cartItems;

                if (liveItems.isEmpty) {
                  return Center(
                    child: Text(
                      "cart_empty".tr,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                // Using ListView.separated to prevent overflow inside the body
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  itemCount: liveItems.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = liveItems[index];
                    return CartItemTile(
                      item: item,
                      onIncrease: () => onIncrease(item),
                      onDecrease: () => onDecrease(item),
                      onDelete: () => onDelete(item),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Use a Container instead of BottomAppBar to solve the overflow problem
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: ProductRepo.cartVersion,
        builder: (context, _, __) {
          final liveItems = ProductRepo.cartItems;
          final liveSubTotal = ProductRepo.getTotalOrderPrice();
          final liveDelivery = ProductRepo.calcDeliveryCharge(liveItems);
          final liveGrandTotal = liveSubTotal + liveDelivery;

          return Container(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              30,
            ), // Extra bottom padding for safe area
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Vital: Allows the column to shrink and fit
              children: [
                _SummaryRow(
                  label: "sub_total".tr,
                  value: "\$${liveSubTotal.toStringAsFixed(2)}",
                ),
                const SizedBox(height: 8),
                _SummaryRow(
                  label: "delivery_charge".tr,
                  value: "\$${liveDelivery.toStringAsFixed(2)}",
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1),
                ),
                _SummaryRow(
                  label: "grand_total".tr,
                  value: "\$${liveGrandTotal.toStringAsFixed(2)}",
                  bold: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: liveItems.isEmpty
                        ? null
                        : () async {
                            ProductRepo.createTransactionFromCart(
                              status: TransactionStatus.paid,
                            );
                            await createOrderDetail();
                            ProductRepo.clearCart();
                            await showSuccess(context, "payment_success".tr);

                            final main = Get.find<MainController>();
                            main.currentIndex.value = 2;
                            Navigator.of(context).popUntil(
                              (route) => route.settings.name == '/home',
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.col4,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "confirm_payment".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  _SummaryRow({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final style = TextStyle(
      fontSize: bold ? 18 : 14,
      fontWeight: bold ? FontWeight.bold : FontWeight.w500,
      color: bold ? (isDark ? Colors.white : Colors.black) : Colors.grey[700],
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
