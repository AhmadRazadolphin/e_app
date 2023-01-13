import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_app/model_class/cart_model.dart';
import 'package:e_app/screens/checkout_screen.dart';
import 'package:flutter/material.dart';

import '../reuseable/app_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);
  // final Mobile_items;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final _cart = CartModel();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Selected products',
                    textStyle: const TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 300),
                  ),
                ],
                totalRepeatCount: 100,
                pause: const Duration(milliseconds: 300),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                  height: height / 1.7,
                  width: width,
                  decoration: BoxDecoration(
                      // color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                            // color: Colors.red,
                            height: height,
                            width: width,
                            child: ListView.builder(
                                itemCount: _cart.items.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                        // selectedColor: Colors.yellow,
                                        // onTap: () {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(const SnackBar(
                                        //           content: Text(
                                        //               "Remove to cart")));
                                        // },
                                        leading: SizedBox(
                                          height: height / 3,
                                          width: width / 5,
                                          child: Image.asset(
                                            _cart.items[index].image.toString(),
                                            height: 80,
                                          ),
                                        ),
                                        title: Text(
                                            _cart.items[index].name.toString()),
                                        subtitle: Text(_cart.items[index].price
                                            .toString()),
                                        trailing: InkWell(
                                            onTap: () {
                                              _cart.remove(_cart.items[index]);
                                              setState(() {});
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Remove to cart")));
                                            },
                                            child: const Icon(Icons.remove))),
                                  );
                                })),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: height / 40,
            ),
            Text(
              "\$${_cart.totalPrice}",
              style: const TextStyle(color: Colors.red, fontSize: 30),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CheckOutScreen()));
              },
              child: const AppButton(
                textButton: 'Confirm',
                iconButton: Icons.arrow_forward_rounded,
                paddingButton: EdgeInsets.only(left: 70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
