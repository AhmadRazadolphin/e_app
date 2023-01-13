// import 'package:e_app/screens/cart_screen.dart';
// import 'package:e_app/screens/checkout_screen.dart';
// import 'package:flutter/material.dart';
//
// class DetailsScreen extends StatefulWidget {
//   const DetailsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }
//
// class _DetailsScreenState extends State<DetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Details'),
//             centerTitle: true,
//             bottom: const TabBar(
//               tabs: [
//                 Tab(icon: Icon(Icons.shopping_cart), text: "Selected product"),
//                 Tab(icon: Icon(Icons.details), text: "Checkout"),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               CartScreen(),
//               CheckOutScreen(),
//             ],
//           ),
//
//         ),
//       ),
//     );
//   }
// }
