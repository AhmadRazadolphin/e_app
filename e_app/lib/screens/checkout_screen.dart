import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_app/controller/profile_controller.dart';
import 'package:e_app/model_class/e_model_class.dart';
import 'package:e_app/model_class/user_model.dart';
import 'package:e_app/screens/order_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model_class/cart_model.dart';
import '../repositories/checkout_repository.dart';
import '../reuseable/app_button.dart';
import '../reuseable/app_text_field.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreen();
}

final controller = ProfileController();

class _CheckOutScreen extends State<CheckOutScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final _nameController = TextEditingController();
  // final _moboileNumberController = TextEditingController();
  // final _addressController = TextEditingController(text: 'the initial value');

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _moboileNumberController.dispose();
  //   _addressController.dispose();
  //   super.dispose();
  // }

  // List<Product>? pros;
  final cart = CartModel();

  var dataDetails;

  @override
  void initState() {
    dataDetails = controller.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade300,
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
                    'Product',
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
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20),
                      child: Card(
                        child: ListTile(
                          title: Text(cart.items[index].name.toString()),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Checkout',
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
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: dataDetails,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          UserModel userModel = snapshot.data as UserModel;
                          // print("snapshot.hasData");
                          // print(snapshot.hasData);
                          return Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                AppTextField(
                                    firstValue: userModel.user_name,
                                    // controller: _nameController,
                                    labelText: "Enter the full name.",
                                    hintText: "Enter the full name."),
                                SizedBox(
                                  height: height / 30,
                                ),
                                AppTextField(
                                    firstValue: userModel.user_mobileNumber,
                                    // controller: _moboileNumberController,
                                    labelText: "Enter the mobile number.",
                                    hintText: "Enter the mobile number."),
                                SizedBox(
                                  height: height / 30,
                                ),
                                AppTextField(
                                    firstValue: userModel.user_address,
                                    // controller: _addressController,
                                    labelText: "Enter the address.",
                                    hintText: "Enter the address."),
                                SizedBox(
                                  height: height / 30,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (totalAmount(cart.items) != 0) {
                                      // addSubCollection(context);
                                      CheckOutRepository c =
                                          CheckOutRepository();
                                      await c.PlaceOrder(
                                        fullName: userModel.user_name ?? '',
                                        phoneNumber:
                                            userModel.user_mobileNumber ?? '',
                                        address: userModel.user_address ?? '',
                                        city: 'city',
                                        zipcode: 'zipcode',
                                        productName: cart.items
                                            .map((e) => e.name ?? '')
                                            .toList(),
                                        productPrice: cart.items
                                            .map((e) => e.price!.toInt())
                                            .toList(),
                                        totalAmount: totalAmount(cart.items),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text("Order Confirm")));

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const OrderHistory()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Product is not selected : Order not confirm.")));
                                    }
                                  },
                                  child: const AppButton(
                                    textButton: 'Confirm',
                                    iconButton: Icons.arrow_forward_rounded,
                                    paddingButton: EdgeInsets.only(left: 70),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.hasError.toString()),
                          );
                        } else {
                          return const Text("Something went wrong");
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> addSubCollection(BuildContext context) async {
  //   final firebaseAuth = FirebaseAuth.instance;
  //   final firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = firebaseAuth.currentUser;
  //   print(user?.displayName.toString());
  //   double amo = double.parse(cart.toString());
  //   CheckOutModel user1 = CheckOutModel(
  //     // firstValue: userModel.user_name  ,
  //     // phoneNo: Phoneno.text,
  //     // address: Address.text,
  //     // city: City.text,
  //     // zipcode: ZipCode.text,
  //     totalAmount: amo,
  //     // productName: pros?[0].name ?? '',
  //   );
  //   try {
  //     await firebaseFirestore
  //         .collection('UserTable')
  //         .doc(user?.uid)
  //         .collection('checkout')
  //         .add(user1.toMap())
  //         .then((value) => print('Order is placed'));
  //   } on FirebaseException catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  double totalAmount(List<Mobile_items> items) {
    int price = 0;
    for (var item in items) {
      price += item.price ?? 0;
    }
    return price.toDouble();
  }
}
