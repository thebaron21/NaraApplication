class ComplainantsModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String comment;
  ComplainantsModel({this.name, this.email, this.phoneNumber, this.comment});

  ComplainantsModel.fromJson(Map<String, dynamic> json)
      : this.name = json["name"],
        this.email = json["email"],
        this.phoneNumber = json["phoneNumber"],
        this.comment = json["comment"];

  toMap() => {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "comment": comment,
      };
}
