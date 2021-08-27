
class ModelCategory {
  
  final int id;
  final String name;
  final String image;
  final String description;
  
  ModelCategory({
    this.id,
    this.name,
    this.image,
    this.description,
  });


   ModelCategory.fromJson(Map<String, dynamic> json) :
        id =  json["id"],
        name =  json["name"],
        image =  json["image"],
        description =  json["description"];
      

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
      };
}
