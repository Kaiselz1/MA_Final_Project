import 'package:flutter/material.dart';
import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/repositories/product_repo.dart';
import 'package:pos_lab/screens/checkout_screen.dart';
import 'package:pos_lab/screens/setting_screen.dart';
import 'package:pos_lab/ui_state/ui_status.dart';

class CartController extends ChangeNotifier {
  UIStatus status = UIStatus.idle;
  String? errorMessage;

  void _setLoading() {
    status = UIStatus.loading;
    notifyListeners();
  }

  void _setSuccess() {
    status = UIStatus.success;
    notifyListeners();
  }

  void _setError(String msg) {
    status = UIStatus.error;
    errorMessage = msg;
    notifyListeners();
  }

  void resetStatus() {
    status = UIStatus.idle;
    errorMessage = null;
    notifyListeners();
  }

  List<CartItem> get items => ProductRepo.cartItems;

  double get subTotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get deliveryCharge => ProductRepo.calcDeliveryCharge(items);

  double get grandTotal => subTotal + deliveryCharge;

  /// Called by View
  void init() {
    notifyListeners();
  }

  Future<void> increaseQty(CartItem item) async {
    ProductRepo.addProductToCart(
      item.product,
      size: item.size,
      sweetness: item.sweetness,
      sugarPercent: item.sugarPercent,
    );
  }

  Future<void> decreaseQty(CartItem item) async {
    ProductRepo.removeFromCart(item);
  }

  Future<void> deleteItem(CartItem item) async {
    ProductRepo.deleteProductFromCart(item.id);
  }

  // Navigation
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
          onBackTap: () => Navigator.pop(context),

          onIncrease: (item) => ProductRepo.addProductToCart(
            item.product,
            size: item.size,
            sweetness: item.sweetness,
            sugarPercent: item.sugarPercent,
          ),

          onDecrease: (item) => ProductRepo.removeFromCart(item),
          onDelete: (item) => ProductRepo.deleteProductFromCart(item.id),

          onConfirmPayment: () {},
        ),
      ),
    );
  }




  
}
