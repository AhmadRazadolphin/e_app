class CheckOutModel {
  String? fullName;
  String? phoneNumber;
  String? address;
  List<dynamic> productName;
  List<dynamic> productPrice;
  double? totalAmount;

  CheckOutModel({
    this.fullName,
    this.phoneNumber,
    this.address,
    required this.productName,
    required this.productPrice,
    this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "phoneNo": phoneNumber,
      "address": address,
      "productName": productName,
      "amount": productPrice,
      "totalAmount": totalAmount,
    };
  }

  factory CheckOutModel.fromJson(Map<String, dynamic> map) {
    return CheckOutModel(
      fullName: map["fullName"].toString(),
      phoneNumber: map["phoneNo"].toString(),
      address: map["address"].toString(),
      productName:
          map["productName"].toString() != null ? map['productName'] : null,
      productPrice: map["productPrice"],
      totalAmount: double.parse(map["totalAmount"].toString()),
    );
  }

  factory CheckOutModel.fromJson1(Map<String, dynamic> data1) {
    return CheckOutModel(
      fullName: data1["fullName"].toString(),
      // fullName: data.id,
      phoneNumber: data1["phoneNo"].toString(),
      address: data1["address"].toString(),
      totalAmount: double.parse(data1["totalAmount"].toString()),
      productName: data1["productName"],
      productPrice: data1["amount"],
    );
  }
}
