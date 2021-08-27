// To parse this JSON data, do
//
//     final myOrdersModel = myOrdersModelFromJson(jsonString);

import 'dart:convert';

MyOrdersModel myOrdersModelFromJson(String str) =>
    MyOrdersModel.fromJson(json.decode(str));

String myOrdersModelToJson(MyOrdersModel data) => json.encode(data.toJson());

class MyOrdersModel {
  MyOrdersModel({
    this.data,
    this.statusCode,
  });

  Data data;
  int statusCode;

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
        data: Data.fromJson(json["data"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "statusCode": statusCode,
      };
}

class Data {
  Data({
    this.data,
  });

  List<MyOrder> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<MyOrder>.from(json["data"].map((x) => MyOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MyOrder {
  MyOrder({
    this.id,
    this.price,
    this.address,
    this.deliveryFees,
    this.paymentType,
    this.paymentStatus,
    this.status,
    this.statusValue,
    this.details,
    this.createdAt,
  });

  int id;
  int price;
  Address address;
  String deliveryFees;
  String paymentType;
  String paymentStatus;
  String status;
  String statusValue;
  List<Detail> details;
  DateTime createdAt;

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        id: json["id"],
        price: json["price"],
        address: Address.fromJson(json["address"]),
        deliveryFees: json["delivery_fees"],
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
        status: json["status"],
        statusValue: json["status_value"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "address": address.toJson(),
        "delivery_fees": deliveryFees,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "status": status,
        "status_value": statusValue,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
      };
}

class Address {
  Address({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.city,
    this.state,
    this.street,
    this.zipCode,
    this.createdAt,
  });

  int id;
  String name;
  String address;
  String phone;
  String city;
  String state;
  String street;
  String zipCode;
  DateTime createdAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        city: json["city"],
        state: json["state"],
        street: json["street"],
        zipCode: json["zip_code"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "city": city,
        "state": state,
        "street": street,
        "zip_code": zipCode,
        "created_at": createdAt.toIso8601String(),
      };
}

class Detail {
  Detail({
    this.product,
    this.productDetails,
    this.qty,
    this.price,
  });

  String product;
  ProductDetails productDetails;
  String qty;
  String price;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        product: json["product"],
        productDetails: ProductDetails.fromJson(json["product_details"]),
        qty: json["qty"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "product_details": productDetails.toJson(),
        "qty": qty,
        "price": price,
      };
}

class ProductDetails {
  ProductDetails({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.createdAt,
  });

  int id;
  String name;
  String description;
  String price;
  String image;
  DateTime createdAt;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "created_at": createdAt.toIso8601String(),
      };
}