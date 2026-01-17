import 'package:pos_lab/models/cart_items.dart';

class TransactionModel {
  final String id;
  final DateTime createdAt;

  final double subTotal;
  final double deliveryCharge;
  final double grandTotal;

  final List<TransactionItem> items;

  final TransactionStatus status;

  const TransactionModel({
    required this.id,
    required this.createdAt,
    required this.subTotal,
    required this.deliveryCharge,
    required this.grandTotal,
    required this.items,
    this.status = TransactionStatus.paid,
  });

  int get totalQty => items.fold(0, (sum, e) => sum + e.qty);
}

enum TransactionStatus {
  paid,
  pending,
  cancelled,
  refunded,
}

class TransactionItem {
  final int productId;
  final String name;
  final String image;
  final double unitPrice;
  final int qty;

  /// Customization snapshot (from ProductDetailScreen)
  final String size;         // "Normal", "Large", etc.
  final String sweetness;    // "Standard", "Less", "None", etc.
  final double sugarPercent; // 0 - 100

  const TransactionItem({
    required this.productId,
    required this.name,
    required this.image,
    required this.unitPrice,
    required this.qty,
    required this.size,
    required this.sweetness,
    required this.sugarPercent,
  });

  double get total => unitPrice * qty;

  factory TransactionItem.fromCartItem(CartItem c) {
    return TransactionItem(
      productId: c.product.id,
      name: c.product.name,
      image: c.product.image,
      unitPrice: c.product.price,
      qty: c.qty,
      size: c.size,
      sweetness: c.sweetness,
      sugarPercent: c.sugarPercent,
    );
  }
}
