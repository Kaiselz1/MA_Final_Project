import 'package:flutter/foundation.dart';
import 'package:pos_lab/models/product.dart';

class CartItem {
  final int id;
  final Product product;


  final String size;         
  final String sweetness;    
  final double sugarPercent; 

  int _qty = 0;
  final ValueNotifier<int> qtyNotifier = ValueNotifier<int>(0);

  CartItem({
    required this.id,
    required this.product,
    int qty = 1,

    required this.size,
    required this.sweetness,
    required this.sugarPercent,
  }) {
    _qty = qty;
    qtyNotifier.value = qty;
  }

  int get qty => _qty;

  set qty(int value) {
    _qty = value;
    qtyNotifier.value = value;
  }

  double get totalPrice => product.price * qty;

  String get strTotalPrice => '\$${totalPrice.toStringAsFixed(2)}';

  bool isSameLineAs(Product p, String size, String sweetness, double sugarPercent) {
    return product.id == p.id &&
        this.size == size &&
        this.sweetness == sweetness &&
        this.sugarPercent == sugarPercent;
  }
}
