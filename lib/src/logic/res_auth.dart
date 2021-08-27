import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/src/config/end_point.dart';
import 'package:myapp3/src/function/res_function.dart';

class ResAuth {
  static String _token = Hive.box(Boxs.NaraApp).get("token"); 

  static Future login({String email, String password}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.loginUrl,
        body: {
          "email": email,
          "password": password,
        },
        headers: ResFunction.withOutToken(),
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future register({String name, String email, String password}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.registerUrl,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password
        },
        headers: ResFunction.withOutToken(),
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future forgot({String email}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.forgetPassUrl,
        headers: ResFunction.withOutToken(),
        body: {
          "email": email,
        },
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future reset({String email, String otp, String password}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.resetPassUrl,
        headers: ResFunction.withOutToken(),
        body: {
          'email': email,
          'password': password,
          'password_confirmation': password,
          'code': otp,
        },
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future edit({String email, String mobile, String name}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.updateProfileUrl,
        body: {
          'name': name,
          'email': email,
          'mobile': mobile,
        },
        headers: ResFunction.withToken(_token),
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future profile() async {
    try {
      var data = await ResFunction.getRes(
        url: EndPoint.getProfileUrl,
        headers: ResFunction.withToken(_token),
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future editP({String newPass, String oldPass}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.changePassUrl,
        body: {
          'password': newPass,
          'password_confirmation': newPass,
          'old_password': oldPass
        },
        headers: ResFunction.withToken(_token),
      );
    } catch (e) {
      return e;
    }
  }
}
