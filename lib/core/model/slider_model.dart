class SliderImage {
  // final int id;
  final String image;

  SliderImage(this.image);

  SliderImage.fromJson(Map<String, dynamic> json)
      : 
      // id = json["id"],
        image = json["image"];
}
