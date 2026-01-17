import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:pos_lab/models/cart_items.dart";
import "package:pos_lab/repositories/product_repo.dart";
import "package:pos_lab/screens/cart_screen.dart";
import "package:pos_lab/style/color.dart";
import "package:pos_lab/widgets/header_widget.dart";

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreen();
}

class _CheckoutScreen extends State<CheckoutScreen> {
  bool isLoading = true;

  List<CartItem> get items => ProductRepo.cartItems;

  double get subTotal =>
      items.fold(0, (sum, cartItem) => sum + cartItem.totalPrice);

  double get deliveryCharge => items.isEmpty ? 0 : 2;
  double get grandTotal => subTotal + deliveryCharge;

  @override
  void initState() {
    super.initState();
    // loadCartFromApi();
    isLoading = false; // remove this when use real API
  }

  Future<void> increaseQty(CartItem item) async {
    setState(() => item.qty += 1);

    // TODO: call API
    // await api.updateCartItemQty(item.id, item.qty);
  }

  Future<void> decreaseQty(CartItem item) async {
    if (item.qty <= 0) return;
    setState(() => ProductRepo.removeFromCart(item));

    // TODO: call API
    // await api.updateCartItemQty(item.id, item.qty);
  }

  Future<void> deleteItem(CartItem item) async {
    setState(() => ProductRepo.deleteProductFromCart(item.id));

    // TODO: call API
    // await api.deleteCartItem(item.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.col8,
      body: Stack(
        children: [
          Column(
            children: [
              AppTitleHeader(
                title: 'Checkout',
                onBackTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        child: Column(
                          children: [
                            // Cart items (REAL DATA)
                            ...items.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: CartItemTile(
                                  item: item,
                                  onIncrease: () => increaseQty(item),
                                  onDecrease: () => decreaseQty(item),
                                  onDelete: () => deleteItem(item),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CartScreen(),
                                  ),
                                ),
                                icon: const Icon(Icons.chevron_left),
                                label: const Text("Back to Cart"),
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

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        color: Colors.white,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              // Summary
              _SummaryRow(
                label: "Sub total",
                value: "\$${subTotal.toStringAsFixed(2)}",
              ),
              const SizedBox(height: 6),
              _SummaryRow(
                label: "Delivery Charge",
                value: "\$${deliveryCharge.toStringAsFixed(2)}",
              ),

              const SizedBox(height: 12),
              const Divider(height: 1, color: Colors.black12),
              const SizedBox(height: 12),

              _SummaryRow(
                label: "Grand Total",
                value: "\$${grandTotal.toStringAsFixed(2)}",
                bold: true,
              ),

              const SizedBox(height: 14),

              // Button
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: items.isEmpty ? null : () {},
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
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFB8AAA0)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14),
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

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFEAE2DA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.coffee, color: Colors.black54);
                  },
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _QtyButton(icon: Icons.remove, onTap: onDecrease),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${item.qty}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _QtyButton(icon: Icons.add, onTap: onIncrease),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
