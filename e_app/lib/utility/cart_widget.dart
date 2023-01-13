// import 'package:flutter/material.dart';
//
// class CartWidget extends StatelessWidget {
//   final CartModel;
//
//   CartWidget({super.key, required this.CartModel}) : assert(CartModel != null);
//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Card(
//         child: ListTile(
//             selectedColor: Colors.yellow,
//             onTap: () {
//               ScaffoldMessenger.of(context)
//                   .showSnackBar(SnackBar(content: Text("Remove to cart")));
//             },
//             leading: Container(
//               height: height / 3,
//               width: width / 5,
//               child: Image.asset(
//                 CartModel.image,
//                 height: 80,
//               ),
//             ),
//             title: Text(CartModel.name),
//             subtitle: Text(CartModel.price.toString()),
//             trailing: Icon(Icons.remove)),
//       ),
//     );
//   }
// }
