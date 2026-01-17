import 'package:pos_lab/models/cart_items.dart';
import 'package:pos_lab/models/product.dart';

class ProductRepo {
  static List<Product> products = [];
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
