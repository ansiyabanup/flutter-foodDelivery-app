import 'package:ecommerce_app1/provider/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// class Review extends StatelessWidget {
//   const Review({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final provider = context.watch<ProductProvider>();
//     return ListView.builder(
//   shrinkWrap: true,
//   physics: const NeverScrollableScrollPhysics(),
//   itemCount: products.reviews.length,
//   itemBuilder: (context, index) {
//     final review = products.reviews[index];

//     return Card(
//       child: ListTile(
//         title: Text('User ${review.userId}'),
//         subtitle: Text(review.comment),
//         trailing: Text('⭐ ${review.rating}'),
//       ),
//     );
//   },
// )
//   }
// }