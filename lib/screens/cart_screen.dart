import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
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

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin{
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
    if (ProductRepo.cartItems.isEmpty && ProductRepo.products.isNotEmpty) {
      ProductRepo.addProductToCart(ProductRepo.products[0]);
      if (ProductRepo.products.length > 1) {
        ProductRepo.addProductToCart(ProductRepo.products[1]);
      }
    }
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
    super.build(context);
    return Scaffold(
      backgroundColor: AppColor.col8,
      body: Stack(
        children: [
          Column(
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
                            const begin = Offset(-1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeOutCubic;

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
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 46,
                              child: ElevatedButton(
                                onPressed: items.isEmpty
                                    ? null
                                    : () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const CheckoutScreen(),
                                          ),
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.col4,
                                  elevation: 1,
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
