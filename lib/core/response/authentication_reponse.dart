import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:myapp3/config/end_point_path.dart';
import 'package:myapp3/core/api/app_exception.dart';
import 'package:myapp3/core/controller/hive_box.dart';
import 'package:myapp3/core/repoitorites/user_repoitory.dart';

class AuthenticationResponse {
  
  Future<UserRespoitory> register({name, email, password, confirmPass}) async {
    var data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPass
    };
    http.Response _response;
    try {
      _response =
          await http.post(Uri.parse(EndPointPath.registerUrl), body: data);
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return UserRespoitory.fromMap(json.decode(_response.body));
      } else {
        return UserRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return UserRespoitory.withException(e.toString());
    } on BadRequestException catch (e) {
      return UserRespoitory.withException(e.toString());
    } on InvalidInputException catch (e) {
      return UserRespoitory.withException(e.toString());
    } on InternalServerError catch (e) {
      return UserRespoitory.withException(e.toString());
    } on SocketException catch (e) {
      return UserRespoitory.withException(e.toString());
    }
  }

  Future<UserRespoitory> login({email, password}) async {
    var data = {
      'email': email,
      'password': password,
    };
    http.Response _response;
    try {
      _response = await http.post(Uri.parse(EndPointPath.loginUrl), body: data);
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return UserRespoitory.fromMap(json.decode(_response.body));
      } else if (body["statusCode"] == 422) {
        return UserRespoitory.withException(body["error"]);
      } else {
        return UserRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return UserRespoitory.withError(e.toString());
    } on BadRequestException catch (e) {
      return UserRespoitory.withError(e.toString());
    } on InvalidInputException catch (e) {
      return UserRespoitory.withError(e.toString());
    } on InternalServerError catch (e) {
      return UserRespoitory.withError(e.toString());
    } on SocketException catch (e) {
      return UserRespoitory.withException("Not Connected");
    }
  }

  /// Get Profile Uri => [getProfileUrl]
  Future<ProfileUserRespoitory> getProfile({String token}) async {
    String token = hiveBox.boxNaraApp.get("token");

    var headers = {'Authorization': 'Bearer $token'};
    http.Response _response;
    try {
      _response = await http.get(Uri.parse(EndPointPath.getProfileUrl),
          headers: headers);
      var body = json.decode(_response.body);
      if (body["statusCode"] == 200) {
        return ProfileUserRespoitory.fromMap(json.decode(_response.body));
      } else if (body["statusCode"] == 401) {
        return ProfileUserRespoitory.withException(body["error"]);
      } else {
        return ProfileUserRespoitory.withError(body);
      }
    } on FetchDataException catch (e) {
      return ProfileUserRespoitory.withError(e.toString());
    } on BadRequestException catch (e) {
      return ProfileUserRespoitory.withError(e.toString());
    } on InvalidInputException catch (e) {
      return ProfileUserRespoitory.withError(e.toString());
    } on InternalServerError catch (e) {
      return ProfileUserRespoitory.withError(e.toString());
    } on SocketException catch (e) {
      return ProfileUserRespoitory.withException("Not Connected");
    }
  }

  Future<bool> editPassword(
      String pass, String confirmPass, String oldPass) async {
    String token = hiveBox.boxNaraApp.get("token");
    Map<String, dynamic> data = {
      'password': pass,
      'password_confirmation': confirmPass,
      'old_password': oldPass
    };
    var headers = {'Authorization': 'Bearer $token'};

    http.Response _response;
    try {
      _response = await http.post(
        Uri.parse(EndPointPath.changePassUrl),
        body: data,
        headers: headers,
      );
      var body = json.decode(_response.body);
      if (_response.statusCode == 200) {
        if (body["statusCode"] == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Dio _dio = Dio();
  Future<bool> forgetPass({String email}) async {
    try {
      var data = {
        'email': email,
      };
      var _response = await http.post(
        Uri.parse("http://larra.xyz/api/forget-password"),
        body: data,
      );
      var body = json.decode(_response.body);
      if (_response.statusCode == 202) {
        return true;
      } else if (_response.statusCode == 422) {
        print(_response.statusCode);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPass(
      {String email, String pass, String passConfirm, String code}) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': pass,
      'password_confirmation': passConfirm,
      'code': code
    };

    http.Response _response;
    try {
      _response = await http.post(
        Uri.parse(EndPointPath.resetPassUrl),
        body: data,
      );
      var body = json.decode(_response.body);
      if (_response.statusCode == 200) {
        if (body == "تم ارسال رمز التاكيد") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProfile(String name, String phone, String email) async {
    String token = hiveBox.boxNaraApp.get("token");

    Map<String, String> data = {
      'name': name,
      'email': email,
      'mobile': phone,
    };
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    http.Response _response;
    try {
      _response = await http.post(Uri.parse(EndPointPath.updateProfileUrl),
          body: data, headers: headers);
      var body = json.decode(_response.body);
      if (_response.statusCode == 200) {
        if (body["statusCode"] == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // TODO:Make Login By FaceBook
}
