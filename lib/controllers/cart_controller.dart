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

  double get deliveryCharge =>  ProductRepo.calcDeliveryCharge(items);

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutScreen(
          isLoading: false,
          items: ProductRepo.cartItems,
          subTotal: ProductRepo.getTotalOrderPrice(),
          deliveryCharge: ProductRepo.cartItems.isEmpty ? 0 : 2,
          grandTotal:
              ProductRepo.getTotalOrderPrice() +
              (ProductRepo.cartItems.isEmpty ? 0 : 2),
          onBackTap: () => Navigator.pop(context),
          onIncrease: (item) => ProductRepo.addProductToCart(item.product),
          onDecrease: (item) => ProductRepo.removeFromCart(item),
          onDelete: (item) => ProductRepo.deleteProductFromCart(item.id),
          onConfirmPayment: () {},
        ),
      ),
    );
  }
}
