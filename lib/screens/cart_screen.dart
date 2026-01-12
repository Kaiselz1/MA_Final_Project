import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
<<<<<<< HEAD
import "package:pos_lab/models/cart_items.dart";
import "package:pos_lab/repositories/product_repo.dart";
import "package:pos_lab/screens/category_screen.dart";
import "package:pos_lab/screens/checkout_screen.dart";
import "package:pos_lab/screens/home_screen.dart";
import "package:pos_lab/screens/setting_screen.dart";
=======
import "package:pos_lab/screens/home_screen.dart";
>>>>>>> 0168936 (update)
import "package:pos_lab/style/color.dart";
import "package:pos_lab/widgets/header_widget.dart";
import "package:pos_lab/widgets/navigate_widget.dart";

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = true;
  int _currentIndex = 1;
  final String _selectedCategoryPath = "cart";

<<<<<<< HEAD
  List<CartItem> get items => ProductRepo.cartItems;
=======
  final List<CartItemModel> items = [
    CartItemModel(
      id: "1",
      title: "Cappuccino",
      price: 20,
      imageUrl:
          "https://www.nescafe.com/nz/sites/default/files/2023-09/NESCAF%C3%89%20Cappuccino.jpg",
      qty: 2,
    ),
    CartItemModel(
      id: "2",
      title: "Black Coffee",
      price: 17,
      imageUrl: "",
      qty: 1,
    ),
    CartItemModel(
      id: "3",
      title: "Latte Coffee",
      price: 15,
      imageUrl: "",
      qty: 2,
    ),
  ];
>>>>>>> 0168936 (update)

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
    return Scaffold(
      backgroundColor: AppColor.col8,
<<<<<<< HEAD
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
                            ...items.map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CartItemTile(
                                    item: item,
                                    onIncrease: () => increaseQty(item),
                                    onDecrease: () => decreaseQty(item),
                                    onDelete: () => deleteItem(item),
                                  ),
                                )),
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
=======
      appBar: AppBar(
        elevation: 5,
        backgroundColor: AppColor.col6,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: AppColor.col4),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
        ),
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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

                  // Summary (REAL TOTALS)
                  _SummaryRow(
                    label: "Sub total",
                    value: "\$${subTotal.toStringAsFixed(2)}",
                  ),
                  const SizedBox(height: 6),
                  _SummaryRow(
                    label: "Delivery Charge",
                    value: "\$${deliveryCharge.toStringAsFixed(2)}",
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Colors.black),
                  const SizedBox(height: 14),
                  _SummaryRow(
                    label: "Grand Total",
                    value: "\$${grandTotal.toStringAsFixed(2)}",
                    bold: true,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
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

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        color: Colors.white,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(
                  icon: Icons.home_filled,
                  onTap: () {
                    //add home screen
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(icon: CupertinoIcons.cart, onTap: () {}),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(
                  icon: Icons.history,
                  onTap: () {
                    //History Screen
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(
                  icon: CupertinoIcons.heart_fill,
                  onTap: () {
                    //Favorite Screen
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: BottomNavItem(
                  icon: Icons.person,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
>>>>>>> 0168936 (update)
              ),
            ],
          ),
        ],
      ),

      
       bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == _currentIndex) return;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
            return;
          }
          setState(() {
            _currentIndex = index;
          });
        },
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

<<<<<<< HEAD


=======
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

// Working with Items

class CartItemModel {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  int qty;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.qty,
  });
}
>>>>>>> 0168936 (update)

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
<<<<<<< HEAD
                child: Image.asset(
                  item.product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.coffee, color: Colors.black54);
                  },
                ),
=======
                child: item.imageUrl.isNotEmpty
                    ? Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.coffee,
                            color: Colors.black54,
                          );
                        },
                      )
                    : const Icon(Icons.coffee, color: Colors.black54),
>>>>>>> 0168936 (update)
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
<<<<<<< HEAD
                  Text(item.product.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text('\$${item.product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.brown,
                          fontWeight: FontWeight.w600)),
=======
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
>>>>>>> 0168936 (update)
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
