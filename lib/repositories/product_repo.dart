import 'package:flutter/foundation.dart';
import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/models/transaction.dart';

class ProductRepo {
  static final ValueNotifier<int> cartVersion = ValueNotifier<int>(0);

  static void _notifyCartChanged() => cartVersion.value++;

  static List<Product> products = [];
  static List<CartItem> cartItems = [];

  static final ValueNotifier<int> transactionVersion = ValueNotifier<int>(0);
  static void _notifyTransactionChanged() => transactionVersion.value++;
  static double calcDeliveryCharge(List<CartItem> items) =>
      items.isEmpty ? 0 : 3.15;

  static final List<TransactionModel> transactions = [];

  // Add this for category filtering
  static final ValueNotifier<String?> selectedCategory = ValueNotifier(null);

  static List<Product> get filteredProducts {
    if (selectedCategory.value == null) return products;
    return products
        .where((p) => p.categoryName == selectedCategory.value)
        .toList();
  }

  static void addProductToCart(
    Product product, {
    required String size,
    required String sweetness, // Removed default "standard"
    required String sugarPercent,
    int qty = 1, // 👈 ADD THIS
  }) {
    final index = cartItems.indexWhere(
      (item) => item.isSameLineAs(product, size, sweetness, sugarPercent),
    );

    if (index != -1) {
      cartItems[index].qty += qty;
    } else {
      cartItems.add(
        CartItem(
          id: DateTime.now().microsecondsSinceEpoch,
          product: product,
          qty: qty,
          size: size,
          sweetness: sweetness,
          sugarPercent: sugarPercent,
        ),
      );
    }
    _notifyCartChanged();
  }

  static void removeFromCart(CartItem item) {
    final existingItemIndex = cartItems.indexWhere(
      (cartItem) => cartItem.id == item.id,
    );

    if (existingItemIndex != -1) {
      if (cartItems[existingItemIndex].qty > 1) {
        cartItems[existingItemIndex].qty -= 1;
      } else {
        cartItems.removeAt(existingItemIndex);
      }
    }

    getTotalItem();
    getTotalOrderPrice();
    _notifyCartChanged();
  }

  static void clearCart() {
    cartItems.clear();
    getTotalOrderPrice();
    getTotalItem();
    _notifyCartChanged();
  }

  static void deleteProductFromCart(int id) {
    cartItems.removeWhere((element) => element.id == id);
    _notifyCartChanged();
  }

  static int getTotalItem() {
    int item = 0;
    for (var element in cartItems) {
      item += element.qty;
    }
    return item;
  }

  static double getTotalOrderPrice() {
    double price = 0;
    for (var element in cartItems) {
      price += element.totalPrice;
    }
    return price;
  }

  static TransactionModel createTransactionFromCart({
    TransactionStatus status = TransactionStatus.paid,
  }) {
    final itemsSnapshot = cartItems
        .map((c) {
          return TransactionItem(
            productId: c.product.id,
            name: c.product.name,
            image: c.product.imageUrl,
            unitPrice: c.product.price,
            qty: c.qty,
            size: c.size,
            sweetness: c.sweetness,
            sugarPercent: c.sugarPercent,
          );
        })
        .toList(growable: false);

    final subTotal = getTotalOrderPrice();
    final deliveryCharge = ProductRepo.calcDeliveryCharge(cartItems);
    final grandTotal = subTotal + deliveryCharge;

    final trx = TransactionModel(
      id: "TRX-${DateTime.now().millisecondsSinceEpoch}",
      createdAt: DateTime.now(),
      subTotal: subTotal,
      deliveryCharge: double.parse(deliveryCharge.toStringAsFixed(2)),
      grandTotal: grandTotal,
      items: itemsSnapshot,
      status: status,
    );

    transactions.insert(0, trx);
    _notifyTransactionChanged();
    return trx;
  }
}
