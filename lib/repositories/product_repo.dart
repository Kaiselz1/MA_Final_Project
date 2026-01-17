import 'package:flutter/foundation.dart';
import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/models/product.dart';
import 'package:pos_lab/models/transaction.dart';

class ProductRepo {
  static final ValueNotifier<int> cartVersion = ValueNotifier<int>(0);

  static void _notifyCartChanged() => cartVersion.value++;

  static List<Product> products = [
    Product(
      id: 1,
      name: "Iced Latte",
      category: "Iced Coffee",
      image: ('assets/images/products/iced_latte.png'),
      price: 1.50,
      stock: 100,
      description:
          "A refreshing iced latte crafted from rich, freshly brewed espresso poured over ice and blended smoothly with cold, creamy milk, creating a perfectly balanced drink that is light, energizing, and delightfully smooth—ideal for cooling down while enjoying a bold yet mellow coffee flavor.",
    ),

    Product(
      id: 2,
      name: "Iced Americano",
      category: "Iced Coffee",
      image: "assets/images/products/iced_americano.png",
      price: 1.25,
      stock: 100,
      description:
          "A cool and invigorating iced americano with a bold espresso flavor.",
    ),

    Product(
      id: 3,
      name: "Iced Cappuccino",
      category: "Iced Coffee",
      image: "assets/images/products/iced_capuccino.png",
      price: 1.50,
      stock: 100,
      description:
          "A creamy iced cappuccino with a perfect balance of espresso and steamed milk.",
    ),

    Product(
      id: 4,
      name: "Iced Mocha",
      category: "Iced Coffee",
      image: "assets/images/products/iced_mocha.png",
      price: 2.75,
      stock: 100,
      description:
          "A delicious iced mocha combining rich chocolate and bold espresso flavors.",
    ),

    Product(
      id: 5,
      name: "Hot Americano",
      category: "Hot Coffee",
      image: "assets/images/products/hot_americano.png",
      price: 1.50,
      stock: 100,
      description:
          "A warm and comforting hot americano with a robust espresso taste.",
    ),

    Product(
      id: 6,
      name: "Hot Latte",
      category: "Hot Coffee",
      image: "assets/images/products/hot_latte.png",
      price: 1.00,
      stock: 100,
      description:
          "A smooth and creamy hot latte made with espresso and steamed milk.",
    ),

    Product(
      id: 7,
      name: "Hot Cappuccino",
      category: "Hot Coffee",
      image: "assets/images/products/hot_cappuccino.png",
      price: 1.00,
      stock: 100,
      description:
          "A frothy hot cappuccino with a perfect blend of espresso and steamed milk.",
    ),

    Product(
      id: 8,
      name: "Matcha Frappe",
      category: "Frappuccino",
      image: "assets/images/products/matcha_frappe.png",
      price: 3.00,
      stock: 100,
      description:
          "A refreshing matcha frappe made with finely ground green tea and blended with ice.",
    ),

    Product(
      id: 9,
      name: "Mocha Frappe",
      category: "Frappuccino",
      image: "assets/images/products/mocha_frappe.png",
      price: 3.00,
      stock: 100,
      description:
          "A delightful mocha frappe combining rich chocolate and espresso flavors, blended with ice.",
    ),

    Product(
      id: 10,
      name: "Strawberry Frappe",
      category: "Frappuccino",
      image: "assets/images/products/strawberry_frappe.png",
      price: 3.25,
      stock: 100,
      description:
          "A sweet and fruity strawberry frappe made with fresh strawberries and blended with ice.",
    ),

    Product(
      id: 11,
      name: "Iced Honey Lemon",
      category: "Iced Drink",
      image: "assets/images/products/iced_honey_lemon.png",
      price: 1.75,
      stock: 100,
      description:
          "A refreshing iced honey lemon drink made with fresh lemon juice and sweet honey.",
    ),

    Product(
      id: 12,
      name: "Iced Black Lemon Tea",
      category: "Iced Drink",
      image: "assets/images/products/iced_black_lemon_tea.png",
      price: 1.75,
      stock: 100,
      description:
          "A cool and tangy iced black lemon tea made with brewed black tea and fresh lemon juice.",
    ),

    Product(
      id: 13,
      name: "Iced Matcha Latte",
      category: "Iced Drink",
      image: "assets/images/products/iced_matcha_latte.png",
      price: 2.25,
      stock: 100,
      description:
          "A refreshing iced matcha latte made with finely ground green tea and chilled milk.",
    ),

    Product(
      id: 14,
      name: "Hot Black Lemon Tea",
      category: "Hot Drink",
      image: "assets/images/products/hot_black_lemon_tea.png",
      price: 1.25,
      stock: 100,
      description:
          "A warm and soothing hot black lemon tea made with brewed black tea and fresh lemon juice.",
    ),

    Product(
      id: 15,
      name: "Hot Matcha Latte",
      category: "Hot Drink",
      image: "assets/images/products/hot_matcha_latte.png",
      price: 1.75,
      stock: 100,
      description:
          "A comforting hot matcha latte made with finely ground green tea and steamed milk.",
    ),

    Product(
      id: 16,
      name: "Hot Chocolate",
      category: "Hot Drink",
      image: "assets/images/products/hot_chocolate.png",
      price: 2.50,
      stock: 100,
      description:
          "A rich and creamy hot chocolate made with melted chocolate and steamed milk.",
    ),

    Product(
      id: 17,
      name: "Burger",
      category: "Food & Snacks",
      image: "assets/images/products/burger.png",
      price: 2.50,
      stock: 100,
      description:
          "A juicy burger made with a flavorful beef patty, fresh lettuce, tomato, and cheese in a soft bun.",
    ),

    Product(
      id: 18,
      name: "Galic Bread",
      category: "Food & Snacks",
      image: "assets/images/products/galic_bread.png",
      price: 1.50,
      stock: 100,
      description:
          "A delicious garlic bread made with fresh bread, garlic butter, and herbs, baked to perfection.",
    ),

    Product(
      id: 19,
      name: "Grilled Chess Sandwich",
      category: "Food & Snacks",
      image: "assets/images/products/grill_chess.png",
      price: 1.50,
      stock: 100,
      description:
          "A tasty grilled cheese sandwich made with melted cheese between two slices of buttery grilled bread.",
    ),
  ];
  static List<CartItem> cartItems = [];
  static final ValueNotifier<int> transactionVersion = ValueNotifier<int>(0);
  static void _notifyTransactionChanged() => transactionVersion.value++;
  static double calcDeliveryCharge(List<CartItem> items) =>
      items.isEmpty ? 0 : 3.15;

  static final List<TransactionModel> transactions = [];

  static void addProductToCart(
    Product product, {
    String size = "Normal",
    String sweetness = "Standard",
    double sugarPercent = 50.0,
  }) {
    final index = cartItems.indexWhere(
      (item) => item.isSameLineAs(product, size, sweetness, sugarPercent),
    );

    if (index != -1) {
      cartItems[index].qty += 1;
    } else {
      cartItems.add(
        CartItem(
          id: DateTime.now().microsecondsSinceEpoch,
          product: product,
          qty: 1,
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
            image: c.product.image,
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
