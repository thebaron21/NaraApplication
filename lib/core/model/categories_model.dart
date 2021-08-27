
// import 'dart:convert';

// CategoriesModel categoriesModelFromJson(String str) =>
//     CategoriesModel.fromJson(json.decode(str));

// String categoriesModelToJson(CategoriesModel data) =>
//     json.encode(data.toJson());

// class CategoriesModel {
//   CategoriesModel({
//     this.data,
//     this.statusCode,
//   });

//   Data data;
//   int statusCode;

//   factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
//       CategoriesModel(
//         data: Data.fromJson(json["data"]),
//         statusCode: json["statusCode"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//         "statusCode": statusCode,
//       };
// }

// class Data {
//   Data({
//     this.categoyList,
//   });

//   List<CategoryModel> categoyList;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         categoyList:
//             List<CategoryModel>.from(json["data"].map((x) => CategoryModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(categoyList.map((x) => x.toJson())),
//       };
// }

class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.description,
    this.createdAt,
  });

  int id;
  String name;
  String image;
  String description;
  DateTime createdAt;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "created_at": createdAt.toIso8601String(),
      };
}
