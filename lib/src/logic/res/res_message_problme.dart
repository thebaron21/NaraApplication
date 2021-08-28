import 'package:hive/hive.dart';
import '../function/res_function.dart';
import '../config/end_point.dart';
import '../config/end_boxs.dart';

class ResMessagProblme {
  static String _token = Hive.box(EndBoxs.NaraApp).get("token");

  static Future setMessage({String message, String toId}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.message,
        headers: ResFunction.withToken(_token),
        body: {
          "message": message,
          "to_id": toId,
        },
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future getMessage() async {
    try {
      var data = await ResFunction.getRes(
        url: EndPoint.message,
        headers: ResFunction.withToken(_token),
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future setProblme(
      {String username, String mobile, String email, String content}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.problam,
        headers: ResFunction.withToken(_token),
        body: {
          "name": username,
          "email": email,
          "phoneNumber": mobile,
          "comment": content,
        },
      );
      return data;
    } catch (e) {
      throw e;
    }
  }
}
