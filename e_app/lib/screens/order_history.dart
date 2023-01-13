import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_app/Bloc/checkout_bloc/checkout_event.dart';
import 'package:e_app/Bloc/checkout_bloc/checkout_state.dart';
import 'package:e_app/model_class/checkout_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/checkout_bloc/checkout_bloc.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  //  static Route route() {
  final firebaseFirestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderBloc>(context).add(GetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text('Order history'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is ProductLoadedState) {
            List<CheckOutModel> data = state.mydata;
            print("our selected data: $data");
            return ListView.builder(
                itemCount: data.length,
                // print(data.length);
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    data[index].fullName.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    data[index].phoneNumber.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    data[index].address.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    data[index].totalAmount.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text(
                                    data[index].productName.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    data[index].productPrice.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      // ListTile(
                      //   title: Text(
                      //     data[index].fullName.toString(),
                      //     style: const TextStyle(color: Colors.black),
                      //   ),
                      //   trailing: Text(
                      //     data[index].phoneNumber.toString(),
                      //     style: const TextStyle(color: Colors.black),
                      //   ),
                      // ),
                    ),
                  );
                });
          } else if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("No Order"));
          }
        },
      ),
    );
  }
}
