import 'package:e_app/repositories/user_repository.dart';

import '../repositories/checkout_repository.dart';

class ProfileController {
  final _authRepo = AuthRepository();
  getUserData() {
    final email = _authRepo.firebaseAuth.currentUser?.email;
    if (email != null) {
      return _authRepo.getUserDetails(email);
    } else {
      return "Something went wrong: Error";
    }
  }
}

class OrderController {
  final _checkRepo = CheckOutRepository();
  getUserData1() {
    final email = _checkRepo.firebaseAuth.currentUser?.email;
    if (email != null) {
      return _checkRepo.getData1(email);
    } else {
      return "Something went wrong: Error";
    }
  }
}
