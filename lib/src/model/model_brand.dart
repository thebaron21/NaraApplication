class ModelBrand {
  final int id;
  final String name;
  final String desc;
  final String price;
  final String image;

  ModelBrand({this.id, this.name, this.desc, this.price, this.image});

  ModelBrand.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        desc = json["description"],
        price = json["price"],
        image = json["image"];
}
