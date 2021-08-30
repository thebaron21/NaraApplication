import 'dart:io';

import 'package:dio/dio.dart';

class ResFunction {
  static Dio _dio = Dio();
  static Future getRes({String url, Map headers}) async {
    try {
      var _response = await _dio.get(url, options: Options(headers: headers));
      // print(_response.data);
      if (_response.statusCode == 200) return _response.data;
      if (_response.statusCode == 202) return _response.data;
    } on SocketException catch (e) {
      return e;
    } catch (e) {
      if (e is DioError) {
        switch (e.type) {
          case DioErrorType.connectTimeout:
            throw "Error";
            break;
          case DioErrorType.sendTimeout:
            throw "Error";
            break;
          case DioErrorType.receiveTimeout:
            throw "Error";
            break;
          case DioErrorType.response:
            throw "Error";
            break;
          case DioErrorType.cancel:
            throw "Error";
            break;
          case DioErrorType.other:
            throw "Error";
            break;
        }
      }
    }
  }

  static Future postRes({String url, Map headers, body}) async {
    try {
      var _response =
          await _dio.post(url, data: body, options: Options(headers: headers));
      print(_response.data);
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
        } else if (e.response.statusCode == 400) {
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
