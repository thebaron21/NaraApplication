// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    this.data,
    this.statusCode,
  });

  List<Datum> data;
  int statusCode;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.bankAccount,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String bankAccount;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        bankAccount: json["bank_account"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bank_account": bankAccount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
