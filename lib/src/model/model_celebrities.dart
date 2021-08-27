class ModelCelebrity {
  final int id;
  final String name;
  final String description;
  final String image;

  ModelCelebrity({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  ModelCelebrity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        image = json["image"];
}
