
import 'package:ecommerce_app1/provider/Cart_provider.dart';
import 'package:ecommerce_app1/provider/order_provider.dart';
import 'package:ecommerce_app1/services/upi_payment_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_response.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cartProvider.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.items[index];
                      return ListTile(
                        leading: Image.network(item.product.image),
                        title: Text(item.product.name),
                        subtitle: Text('₹ ${item.product.price}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () {
                                cartProvider.addToCart(item.product);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                cartProvider.removeFromCart(item.product);
                              },
                            ),
                            Text(item.quantity.toString()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total: ₹ ${cartProvider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async{
                          final cartProvider = context.read<CartProvider>();

                          final orderProvider = context.read<OrderProvider>();

                          final paymentService = UpiPaymentService();
                          final response =await paymentService
                              .startUpiPayment(cartProvider.totalPrice);

                          if (cartProvider.items.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cart is empty')),
                            );
                            return;
                          }

                          if (response == null) return;

                          switch(response.status) {
                            case UpiPaymentStatus.SUCCESS:

                              orderProvider.placeOrder
                              (cartProvider.items,
                                  cartProvider.totalPrice);

                              cartProvider.clearCart();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Sucessfully paid')),
                              );

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => const OrdersScreen(),
                              //   ),
                              // );
                              break;

                            case UpiPaymentStatus.FAILURE:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Payment failed')),
                              );
                              break;

                              default:
                           
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Payment pending')),
                              );
                            
                            
                          }

                          // showDialog(
                          //   context: context,
                          //   builder: (_) => AlertDialog(
                          //     title: const Text('Mock Payment Sucessdul'),
                          //     content: Text(
                          //         'Payment of ₹${cartProvider.totalPrice.toStringAsFixed(2)} successful!'),
                          //     actions: [
                          //       TextButton(
                          //         onPressed: () async {
                          //           // Save order (locally for now)
                          //           await startUpipayment(
                          //               cartProvider.totalPrice);
                          //           orderProvider.placeOrder(cartProvider.items,
                          //               cartProvider.totalPrice);
                          //           cartProvider.clearCart();
                          //           Navigator.pop(context);
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (_) => const OrdersScreen(),
                          //             ),
                          //           );
                          //         },
                          //         child: const Text('OK'),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                        child: const Text('Pay with upi'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
//vggvgvugfvdf bkjcvndbnj
//tgrbbbfg43rrgggge
