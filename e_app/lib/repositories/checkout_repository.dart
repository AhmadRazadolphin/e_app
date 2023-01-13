import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_app/model_class/checkout_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CheckOutRepository {
  final firebaseAuth = FirebaseAuth.instance;

  final firebaseFirestore = FirebaseFirestore.instance.collection('UserTable');

  Future<void> PlaceOrder({
    required String fullName,
    required String phoneNumber,
    required String address,
    required String city,
    required String zipcode,
    required List<String> productName,
    required List<int> productPrice,
    required double totalAmount,
  }) async {
    User? user = firebaseAuth.currentUser;
    CheckOutModel user1 = CheckOutModel(
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address,
        productName: productName,
        productPrice: productPrice,
        totalAmount: totalAmount);
    final firestore = FirebaseFirestore.instance
        .collection('UserTable')
        .doc(user!.uid)
        .collection('OrderPlace');
    await firestore.add(user1.toMap());
    //Fluttertoast.showToast(msg: 'Order has been placed');
  }

  Future<List<CheckOutModel>> getData1(String email) async {
    List<CheckOutModel> orderList = [];
    try {
      final orderData = await FirebaseFirestore.instance
          .collection('UserTable')
          .where("user_email", isEqualTo: email)
          .get();
      for (var element in orderData.docs) {
        await firebaseFirestore
            .doc(element.id)
            .collection('OrderPlace')
            .get()
            .then((value) {
          for (var element in value.docs) {
            print("co.getdata0");
            print(element.data().toString());
            orderList.add(CheckOutModel.fromJson1(element.data()));
            print("co.getdata1");

            print(element.data());
          }
        });
      }
      return orderList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return orderList;
    } catch (e) {
      print("e.toString()");

      print(e.toString());
      throw Exception(e.toString());
      print(e.toString());
    }
  }

  // Future<List<CheckOutModel>> getData(String email) async {
  //   List<CheckOutModel> orderList = [];
  //
  //   try {
  //     final orderData = await FirebaseFirestore.instance
  //         .collection("UserTable")
  //         .where("user_email", isEqualTo: email)
  //         .get();
  //     for (var element in orderData.docs) {
  //       await firebaseFirestore
  //           .doc(element.id)
  //           .collection('OrderPlace')
  //           .get()
  //           .then((value) {
  //         for (var element in value.docs) {
  //           print("co.getdata0");
  //           // return fetchedData.add(element.data());
  //           orderList.add(CheckOutModel.fromJson(element.data()));
  //           print("co.getdata1");
  //
  //           print(element.data());
  //           //fetchedData.add(element.data());
  //         }
  //       });
  //     }
  //
  //     // orderdata.docs.forEach((element) {
  //     //   return orderList.add(CheckOutModel.fromJson(element.data()));
  //     // });
  //     //print('Data from firestore $orderList');
  //     return orderList;
  //   } on FirebaseException catch (e) {
  //     if (kDebugMode) {
  //       print("Failed with error '${e.code}': ${e.message}");
  //     }
  //     return orderList;
  //   } catch (e) {
  //     print("e.toString()");
  //
  //     print(e.toString());
  //     throw Exception(e.toString());
  //     print(e.toString());
  //   }
  // }
}
