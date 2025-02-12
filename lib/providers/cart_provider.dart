import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<int, Map<String, dynamic>> _cartItems = {}; // {productId: {product: Product, quantity: int}}

  Map<int, Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!['quantity'] += 1;
    } else {
      _cartItems[product.id] = {'product': product, 'quantity': 1};
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      if (_cartItems[product.id]!['quantity'] > 1) {
        _cartItems[product.id]!['quantity'] -= 1;
      } else {
        _cartItems.remove(product.id);
      }
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0.0;
    for (var entry in _cartItems.values) {
      final product = entry['product'] as Product;
      final quantity = entry['quantity'] as int;
      total += product.price * quantity;
    }
    return total;
  }
}
