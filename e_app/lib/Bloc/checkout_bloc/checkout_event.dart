import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  //const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddOrderEvent extends OrderEvent {
  final String fullName;
  final String phoneNo;
  final String address;
  // final String city;
  // final String zipCode;
  final String productNames;
  final double sum;

  AddOrderEvent(
    this.fullName,
    this.phoneNo,
    this.address,
    // this.city, this.zipCode,
    this.productNames,
    this.sum,
  );
}

class GetDataEvent extends OrderEvent {
  GetDataEvent();
}
