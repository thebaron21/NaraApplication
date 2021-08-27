

class User {
  User({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.active,
    this.verfiyCode,
    this.image,
    this.createdAt,
    this.token,
  });

  int id;
  String name;
  dynamic mobile;
  String email;
  String active;
  dynamic verfiyCode;
  String image;
  DateTime createdAt;
  String token;

  factory User.fromJson(Map<String, dynamic> json, var token) => User(
         token: token["token"],
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        active: json["active"],
        verfiyCode: json["verfiy_code"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "active": active,
        "verfiy_code": verfiyCode,
        "image": image,
        "created_at": createdAt.toIso8601String(),
      };
}



class UserProfile {
  UserProfile({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.active,
    this.verfiyCode,
    this.image,
    this.createdAt,
  });

  int id;
  String name;
  dynamic mobile;
  String email;
  String active;
  dynamic verfiyCode;
  String image;
  DateTime createdAt;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        active: json["active"],
        verfiyCode: json["verfiy_code"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "active": active,
        "verfiy_code": verfiyCode,
        "image": image,
        "created_at": createdAt.toIso8601String(),
      };
}