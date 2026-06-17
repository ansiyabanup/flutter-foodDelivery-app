import 'package:ecommerce_app1/models/cart_model.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime date;
   String status;

  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    required this.status,
  });
}
