import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model_class/user_model.dart';

class AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signUp(
      {required String emailU,
      required String nameU,
      required String mobileNumber,
      required String address,
      required String password,
      required String confirmPassword}) async {
    try {
      if (password == confirmPassword) {
        var value = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: emailU, password: password);
        await postDataToFirestore(
            emailU, nameU, mobileNumber, address, password, confirmPassword);
      } else {
        throw Exception('Password and confirm password is not same!');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Your password is weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else if (e.code == 'password-and-confirm-password-is-not-same') {
        throw Exception('Password and confirm password is not same!');
      }
      // else if (password != confirmPassword) {
      //   throw Exception('Password and confirm password is not same!');
      // }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // post data to firestore
  postDataToFirestore(String emailU, String nameU, String mobileNumber,
      String address, String password, String confirmPassword) async {
    User? user = firebaseAuth.currentUser;

    UserModel userModel = UserModel();
    userModel.user_id = user!.uid;
    userModel.user_email = emailU.toString();
    userModel.user_name = nameU.toString();
    userModel.user_mobileNumber = mobileNumber.toString();
    userModel.user_address = address.toString();
    userModel.user_password = password.toString();
    userModel.user_confirmPassword = confirmPassword.toString();

    await firebaseFirestore
        .collection("UserTable")
        .doc(user.uid)
        .set(userModel.toMap());

    // Fluttertoast.showToast(msg: "Account created successfully");
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isSignedIn() async {
    var currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await firebaseFirestore
        .collection("UserTable")
        .where("user_email", isEqualTo: email)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  // Future<List<UserModel>> allUsers(String email) async {
  //   final snapshot = await firebaseFirestore
  //       .collection("UserTable")
  //       .where("email", isEqualTo: email)
  //       .get();
  //   final userData =
  //       snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  //   return userData;
  // }
}
