import 'package:ecommerce_app1/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    //tracking
    final stepsList = ['Ordered', 'Processing', 'Shipped', 'Delivered'];

    int currentStep = stepsList.indexOf(order.status);
    if (currentStep == -1) currentStep = 0;

    return Scaffold(
      appBar: AppBar(title: Text(order.id)),
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text('Order ID: ${order.id}'),
                  Text('Date: ${order.date.toString()}'),
                  Text('Status: ${order.status}'),
                  //buildStepper(order.status),
                  Text('Total: ₹ ${order.total.toStringAsFixed(2)}'),
                  const Divider(),
                  const Text('Items are: ', style: TextStyle(fontSize: 16)),
                  Expanded(
                      child: ListView.builder(
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      final item = order.items[index];
                      return ListTile(
                        leading: Image.network(item.product.image),
                        title: Text(item.product.name),
                        subtitle:
                            Text('₹ ${item.product.price} x ${item.quantity}'),
                      );
                    },
                  ))
                ],
              ),
            ),

            const SizedBox(width: 10),
//stepper
            Expanded(
              flex: 2,
              child: buildStepper(order.status),
            ),
          ],
        ),
      ),
    );
  }
}
//

Widget buildStepper(String status) {
  final stepsList = ['Ordered', 'Processing', 'Shipped', 'Delivered'];

  int currentStep = stepsList.indexOf(status);

  return Stepper(
    type: StepperType.vertical,
    currentStep: currentStep,
    controlsBuilder: (context, details) {
      return const SizedBox(); // ❌ removes buttons
    },
    steps: stepsList.map((step) {
      int index = stepsList.indexOf(step);

      return Step(
        title: Text(step),
        content: const SizedBox(),
        isActive: index <= currentStep,
        state: index < currentStep
            ? StepState.complete
            : index == currentStep
                ? StepState.editing
                : StepState.indexed,
      );
    }).toList(),
  );
}

// Widget buildTracking(String status) {
//   final steps = ['Ordered', 'Processing', 'Shipped', 'Delivered'];
// int currentIndex = steps.indexOf(status);

//   return Column(
//     children: List.generate(steps.length, (index) {
//       final isCompleted = index <= currentIndex;

//       return Row(
//         children: [
//           Icon(
//             isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
//             color: isCompleted ? Colors.green : Colors.grey,
//           ),
//           const SizedBox(width: 8),
//           Text(steps[index]),
//         ],
//       );
//     }),
//   );
// }
//bhiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
