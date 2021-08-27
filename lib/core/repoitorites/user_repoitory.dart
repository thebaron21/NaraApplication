import 'package:myapp3/core/model/user_model.dart';

class ProfileUserRespoitory {
  UserProfile user;
  Map<String, dynamic> error;
  String exception;

  ProfileUserRespoitory.fromMap(Map<String, dynamic> json)
      : user = UserProfile.fromJson(json["data"]),
        error = null,
        exception = null;

  ProfileUserRespoitory.withError(var ex)
      : user = null,
        error = ex["errors"],
        exception = null;

  ProfileUserRespoitory.withException(String ex)
      : user = null,
        error = null,
        exception = ex;
}

class UserRespoitory {
  User user;
  Map<String, dynamic> error;
  String exception;

  UserRespoitory.fromMap(Map<String, dynamic> json)
      : user = User.fromJson(json["data"]["user"], json["data"]),
        error = null,
        exception = null;

  UserRespoitory.withError(var ex)
      : user = null,
        error = ex["errors"],
        exception = null;

  UserRespoitory.withException(String ex)
      : user = null,
        error = null,
        exception = ex;
}