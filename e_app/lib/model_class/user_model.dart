import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? user_id;
  String? user_email;
  String? user_name;
  String? user_mobileNumber;
  String? user_address;
  String? user_password;
  String? user_confirmPassword;

  UserModel(
      {this.user_id,
      this.user_email,
      this.user_name,
      this.user_mobileNumber,
      this.user_address,
      this.user_password,
      this.user_confirmPassword});

  Map<String, dynamic> toMap() {
    return {
      "user_id": user_id,
      "user_email": user_email,
      "user_name": user_name,
      "user_mobileNumber": user_mobileNumber,
      "user_address": user_address,
      "user_password": user_password,
      "user_confirmPassword": user_confirmPassword,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        user_id: map["user_id"],
        user_email: map["user_email"],
        user_name: map["user_name"],
        user_mobileNumber: map["user_mobileNumber"],
        user_address: map["user_address"],
        user_password: map["user_password"],
        user_confirmPassword: map["user_confirmPassword"]);
  }
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      // user_id: data["user_id"],
      user_id: document.id,
      user_email: data["user_email"],
      user_name: data["user_name"],
      user_mobileNumber: data["user_mobileNumber"],
      user_address: data["user_address"],
      // user_password: data["user_password"],
      // user_confirmPassword: data["user_confirmPassword"]
    );
  }
}
