// To parse this JSON data, do
//
//     final celebritiesModel = celebritiesModelFromJson(jsonString);

import 'dart:convert';

class Celebrity {
  Celebrity({
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
  });

  int id;
  String name;
  String description;
  String image;
  DateTime createdAt;

  factory Celebrity.fromJson(Map<String, dynamic> json) => Celebrity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}