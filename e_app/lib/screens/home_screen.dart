import 'dart:convert';

import 'package:e_app/model_class/cart_model.dart';
import 'package:e_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/auth_bloc/auth_bloc.dart';
import '../model_class/e_model_class.dart';
import '../utility/ProductWidget.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownvalue = 'Select category';

  // List of items in our dropdown menu
  var items = [
    'Select category',
    'Vivo mobiles',
    'Samsung Mobiles',
    'Oppo Mobiles',
    'Apple Mobiles',
    'Nokia Mobiles',
  ];
  int valueNumber = 1;
  String select = "Select";

  @override
  initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final dataJson = await rootBundle.loadString("files/data.json");
    final decodedData = jsonDecode(dataJson);
    var productData = decodedData["products"];
    Catalog.products = List.from(productData)
        .map<Mobile_items>((item) => Mobile_items.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // final auth = AuthRepository();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                const Text('E App'),
                SizedBox(
                  width: width / 1.7,
                ),
                InkWell(
                    onTap: () {
                      // auth.signOut().then((value) {
                      //   Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const LoginScreen()));
                      // });
                      context.read<AuthBloc>().add(SignOutRequested());
                      BlocProvider.of<AuthBloc>(context)
                          .add(SignOutRequested());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));

                      final _cart = CartModel();
                      // _cart.items.clear();
                      _cart.delete();
                      print("_cart.items.length");

                      print(_cart.items.length);
                    },
                    child: const Text("Logout")),
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: DropdownButton(
                    dropdownColor: Colors.grey.shade300,
                    // Initial Value
                    value: dropdownvalue,
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),
                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: SizedBox(
                            height: height / 10,
                            width: width / 1.4,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(items),
                            ),
                          ));
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Click for add to Cart")),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                      height: height / 1.6,
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
                              height: height / 1.3,
                              width: width / 1.2,
                              child: (Catalog.products.isNotEmpty &&
                                      Catalog.products != null)
                                  ? ListView.builder(
                                      itemCount: Catalog.products.length,
                                      itemBuilder: (context, index) {
                                        return ProductWidget(
                                          Mobile_items: Catalog.products[index],
                                        );
                                      })
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: height / 18,
                    width: width / 1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CartScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200.0),
                        ),
                      ),
                      child: const Text("Show products"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
