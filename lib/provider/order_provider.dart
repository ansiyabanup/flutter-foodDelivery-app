import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/cart_model.dart';
import 'dart:math';

class OrderProvider with ChangeNotifier {
  
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  String _generateOrderId() {
    final random = Random();
    return 'ORD-${random.nextInt(999999)}';
  }

  void placeOrder(List<CartItem> cartItems, double totalAmount) {
    final newOrder = OrderModel(
      id: _generateOrderId(),
      items: List.from(cartItems),
      total: totalAmount,
      date: DateTime.now(),
      status: 'Pending',
    );

    _orders.insert(0, newOrder);
    notifyListeners();

     // 🔥 Simulate tracking updates
  _simulateTracking(newOrder.id);
}

void _simulateTracking(String orderId) async {
  await Future.delayed(const Duration(seconds: 3));
  _updateStatus(orderId, 'Processing');

  await Future.delayed(const Duration(seconds: 3));
  _updateStatus(orderId, 'Shipped');

  await Future.delayed(const Duration(seconds: 3));
  _updateStatus(orderId, 'Delivered');
}

void _updateStatus(String orderId, String status) {
  final index = _orders.indexWhere((o) => o.id == orderId);
  if (index >= 0) {
    _orders[index].status = status;
    notifyListeners();
  }
  }



  
}