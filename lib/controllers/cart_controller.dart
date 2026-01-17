import 'package:flutter/material.dart';
import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/screens/checkout_screen.dart';
import 'package:pos_lab/screens/setting_screen.dart';

class CartController extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<CartItem> get items => ProductRepo.cartItems;

  double get subTotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get deliveryCharge => items.isEmpty ? 0 : 2;

  double get grandTotal => subTotal + deliveryCharge;

  /// Called by View
  void init() {

    _isLoading = false;
    notifyListeners();
  }

  Future<void> increaseQty(CartItem item) async {
    ProductRepo.addProductToCart(item.product);
  }

  Future<void> decreaseQty(CartItem item) async {
    ProductRepo.removeFromCart(item);
  }

  Future<void> deleteItem(CartItem item) async {
    ProductRepo.deleteProductFromCart(item.id);
  }

  // Navigation (kept OUT of UI logic)
  void openSettings(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (_, __, ___) => const SettingScreen(),
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void proceedToCheckout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CheckoutScreen()),
    );
  }
}
