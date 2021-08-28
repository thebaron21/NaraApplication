import 'package:dio/dio.dart';

class HandleAuth {
  // ignore: missing_return
  static String login(var data) {
    if (data is DioError) {
      print(data.response.data);
      if (data.response.data["errors"]["email"] != null) {
        return data.response.data["errors"]["email"];
      }
    } else {
      print(data);
      return data;
    }
  }

  static Map register(var data) {
    if (data["data"] != null) {
      return {"token": data["data"]["token"], "status": true};
    } else if (data["errors"] != null) {
      return {"status": false, "errors": data["errors"]};
    }
  }
}
