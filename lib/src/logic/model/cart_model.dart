import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'cart_model.g.dart';


@HiveType(typeId: 1)
class CartItemModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String desc;
  @HiveField(3)
  int price;
  @HiveField(4)
  int totalPrice;
  @HiveField(5)
  String image;
  @HiveField(6)
  int count;

  CartItemModel(
      {this.totalPrice,
      this.count,
      this.id,
      this.name,
      this.desc,
      this.price,
      this.image});
  
  toMap() => {
        "id": this.id,
        "name": this.name,
        "descriptioin": this.desc,
        "price": this.price,
        "image": this.image,
        "count": this.count,
        "totalPrice": this.totalPrice,
      };
}

