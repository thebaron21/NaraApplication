
class BrandModel {
  final String id;
  final String name;
  final String image;

  BrandModel(this.id, this.name, this.image);

  BrandModel.fromMap(Map<String, dynamic> json)
      : this.id = json["id"].toString(),
        this.name = json["name"],
        this.image = json["image"];
  // this.products = ProductModel.fromJson(json["products"]);

  toMap() => {"name": this.name, "image": this.image};
}

class BrandModel2 {
  final int id;
  final String name;
  final String desc;
  final String price;
  final String image;

  BrandModel2({this.id, this.name, this.desc, this.price, this.image});

  factory BrandModel2.fromJson(Map<String, dynamic> json) {
    return BrandModel2(
        id: json["id"],
        name: json["name"],
        desc: json["description"],
        price: json["price"],
        image: json["image"]);
  }
}
