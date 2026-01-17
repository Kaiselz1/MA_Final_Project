import 'package:pos_lab/models/product.dart';

class CartItem {
  final int id;
  int? _qty;
  final Product product;
  CartItem({required this.id, required this.product});

  double get totalPrice{
    return product.price * qty;
  }

  int get qty => _qty ?? 0;

  set qty(int value) => _qty = value;

  String get strTotalPrice{
    return '\$${totalPrice.toStringAsFixed(2)}';
  }
}