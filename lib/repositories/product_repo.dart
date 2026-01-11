import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/models/product.dart';

class ProductRepo {
  static List<Product> products = [
    Product(
      id: 1,
      name: "Iced Latte",
      category: "Iced Coffee",
      image: ('assets/images/products/iced_latte.png'),
      price: 1.50,
      stock: 100,
      description:
          "A refreshing iced latte made with espresso and chilled milk.",
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

  static void addProductToCart(Product product) {
    if (cartItems.isEmpty) {
      CartItem item = CartItem(id: 1, product: product);
      item.qty = 1;
      cartItems.add(item);
    } else {
      final existingItemIndex = cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );
      if (existingItemIndex != -1) {
        cartItems[existingItemIndex].qty += 1;
      } else {
        final newItem = CartItem(id: cartItems.length + 1, product: product);
        newItem.qty = 1;
        cartItems.add(newItem);
      }
    }
    getTotalItem();
    getTotalOrderPrice();
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
  }

  static void clearCart() {
    cartItems.clear();
    getTotalOrderPrice();
    getTotalItem();
  }

  static void deleteProductFromCart(int id) {
    cartItems.removeWhere((element) => element.id == id);
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
}
