import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:pos_lab/controllers/setting_controller.dart";
import "package:pos_lab/models/cart_items.dart";
import "package:pos_lab/repositories/product_repo.dart";
import "package:pos_lab/screens/checkout_screen.dart";
import "package:pos_lab/screens/setting_screen.dart";
import "package:pos_lab/style/color.dart";
import "package:pos_lab/widgets/header_widget.dart";

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;

  List<CartItem> get items => ProductRepo.cartItems;
  double get subTotal =>
      items.fold(0, (sum, cartItem) => sum + cartItem.totalPrice);
  double get deliveryCharge => items.isEmpty ? 0 : 2;
  double get grandTotal => subTotal + deliveryCharge;
  final SettingController settings = Get.find<SettingController>();

  @override
  void initState() {
    super.initState();
    // loadCartFromApi();
    if (ProductRepo.cartItems.isEmpty && ProductRepo.products.isNotEmpty) {
      ProductRepo.addProductToCart(ProductRepo.products[0]);
      if (ProductRepo.products.length > 1) {
        ProductRepo.addProductToCart(ProductRepo.products[1]);
      }
    }
    isLoading = false;
  }

  Future<void> increaseQty(CartItem item) async {
    setState(() => item.qty += 1);
  }

  Future<void> decreaseQty(CartItem item) async {
    if (item.qty <= 0) return;
    setState(() => ProductRepo.removeFromCart(item));
  }

  Future<void> deleteItem(CartItem item) async {
    setState(() => ProductRepo.deleteProductFromCart(item.id));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Obx(() {
      final bool isDark = settings.isDark;

      return Scaffold(
        backgroundColor: isDark ? AppColor.col7 : AppColor.col8,
        body: Column(
          children: [
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
                          var tween = Tween(
                            begin: const Offset(-1.0, 0.0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeOutCubic));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                  ),
                );
              },
              showSearchBar: false,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: Column(
                        children: [
                          ...items.map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: CartItemTile(
                                item: item,
                                isDark: isDark,
                                onIncrease: () => increaseQty(item),
                                onDecrease: () => decreaseQty(item),
                                onDelete: () => deleteItem(item),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 46,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: items.isEmpty
                                  ? null
                                  : () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const CheckoutScreen(),
                                      ),
                                    ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.col4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text(
                                "Proceed to Checkout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          border: Border.all(color: isDark ? AppColor.col4 : AppColor.col6),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isDark ? AppColor.col4 : AppColor.col6,
        ),
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final bool isDark;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  const CartItemTile({
    super.key,
    required this.item,
    required this.isDark,
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
        child: Icon(Icons.delete, color: AppColor.col4),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDark ? AppColor.col5 : Colors.white,
            width: 1.0,
          ),
          color: isDark ? AppColor.col6 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
              color: isDark
                  ? Colors.black.withOpacity(0.5)
                  : Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xFFEAE2DA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item.product.image,
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
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.col4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _QtyButton(
                  icon: Icons.remove,
                  onTap: onDecrease,
                  isDark: isDark,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '${item.qty}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                _QtyButton(icon: Icons.add, onTap: onIncrease, isDark: isDark),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
