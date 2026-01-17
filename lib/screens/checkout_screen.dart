import 'package:flutter/material.dart';
import 'package:pos_lab/controllers/main_controller.dart';
import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/models/transaction.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/widgets/header_widget.dart';
import 'package:pos_lab/widgets/cart_item_tile.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.col8,

      body: Column(
        children: [
          AppTitleHeader(title: 'Checkout', onBackTap: onBackTap),
          const SizedBox(height: 40),

          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: ProductRepo.cartVersion,
              builder: (_, __, ___) {

                final liveItems = ProductRepo.cartItems; 

                if (liveItems.isEmpty) {
                  return const Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: Column(
                    children: [
                      ...liveItems.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CartItemTile(
                            item: item,
                            onIncrease: () => onIncrease(item),
                            onDecrease: () => onDecrease(item),
                            onDelete: () => onDelete(item),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: ProductRepo.cartVersion,
        builder: (_, __, ___) {
          final liveItems = ProductRepo.cartItems;
          final liveSubTotal = ProductRepo.getTotalOrderPrice();
          final liveDelivery = ProductRepo.calcDeliveryCharge(liveItems);
          final liveGrandTotal = liveSubTotal + liveDelivery;

          return BottomAppBar(
            notchMargin: 8,
            color: Colors.white,
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: "Sub total",
                    value: "\$${liveSubTotal.toStringAsFixed(2)}",
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: "Delivery Charge",
                    value: "\$${liveDelivery.toStringAsFixed(2)}",
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Colors.black12),
                  const SizedBox(height: 12),
                  _SummaryRow(
                    label: "Grand Total",
                    value: "\$${liveGrandTotal.toStringAsFixed(2)}",
                    bold: true,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: liveItems.isEmpty
                          ? null
                          : () {
                              ProductRepo.createTransactionFromCart(
                                status: TransactionStatus.paid,
                              );
                              ProductRepo.clearCart();
                              final main = Get.find<MainController>();
                              main.currentIndex.value = 2;

                              Navigator.of(context).popUntil((r) => r.isFirst);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.col4,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Confirm Payment",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final weight = bold ? FontWeight.w700 : FontWeight.w500;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: weight)),
        Text(value, style: TextStyle(fontWeight: weight)),
      ],
    );
  }
}
