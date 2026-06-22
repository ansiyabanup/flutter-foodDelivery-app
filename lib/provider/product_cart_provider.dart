import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice => _items.fold(
      0, (sumTotal, item) => sumTotal + (item.product.price * item.quantity));

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index); // Remove if quantity = 1
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// Save order to Firestore
  // Future<void> saveOrder() async {
  //   if (_items.isEmpty) return;

  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return;

  //   final orderData = {
  //     'userId': user.uid,
  //     'products': _items
  //         .map((e) => {
  //               'id': e.product.id,
  //               'name': e.product.name,
  //               'price': e.product.price,
  //               'quantity': e.quantity,
  //             })
  //         .toList(),
  //     'total': totalPrice,
  //     'date': DateTime.now().toIso8601String(),
  //   };

  //   await FirebaseFirestore.instance.collection('orders').add(orderData);

  //   clearCart();
  // }
}
