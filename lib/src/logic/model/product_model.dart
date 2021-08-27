import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String desc;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String image;

  ProductModel({this.id, this.name, this.desc, this.price, this.image});

  ProductModel.fromJson(var json)
      : id = json["id"],
        name = json["name"],
        desc = json["description"],
        price = json["price"],
        image = json["image"];

  toMap() => {
        "id": this.id,
        "name": this.name,
        "descriptioin": this.desc,
        "price": this.price,
        'image': this.image,
      };
}

