import 'package:ecommerce_app1/pages/order_details_screen.dart';
import 'package:ecommerce_app1/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: orders.isEmpty
          ? const Center(child: Text('No orders yet'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return ListTile(
                  title: Text(order.id),
                  subtitle: Text(
                    '₹ ${order.total.toStringAsFixed(2)}',
                  ),
                  trailing: Text(order.status),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            OrderDetailsScreen(order: order),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
