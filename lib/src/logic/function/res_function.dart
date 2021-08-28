import 'package:dio/dio.dart';

class ResFunction {
  static Dio _dio = Dio();
  static Future getRes({String url, Map headers}) async {
    try {
      var _response = await _dio.get(url, options: Options(headers: headers));
      // print(_response.data);
      if (_response.statusCode == 200) return _response.data;
      if (_response.statusCode == 202) return _response.data;
    } catch (e) {
      throw e;
    }
  }

  static Future postRes({String url, Map headers, body}) async {
    try {
      var _response =
          await _dio.post(url, data: body, options: Options(headers: headers));

      if (_response.statusCode == 200) return _response.data;
      if (_response.statusCode == 202) return _response.data;
      if (_response.statusCode == 422) return _response.data;
      if (_response.statusCode == 406) return _response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.response.statusCode == 422) {
          throw e;
        } else if (e.response.statusCode == 406) {
          throw e;
        }
      } else {
        throw e;
      }
    }
  }

  static Map<String, String> withToken(token) =>
      {"Accept": "application/json", 'Authorization': 'Bearer $token'};

  static Map<String, String> withOutToken() => {"Accept": "application/json"};
}
