import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class ApiBaseHelper {
  Map<String, dynamic> _data = {};

  Future<dynamic> getMethod(String url, {Map<String, dynamic> data}) async {
    var responseJson;
    Uri uri = Uri.parse(url);
    final fullUrl = uri.replace(queryParameters: data);

    final response = await http.get(fullUrl, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    responseJson = _returnResponse(response);
    return responseJson;
  }

  Future<dynamic> postMethod(String url,
      {Map<String, dynamic> data = const {}}) async {
    _data.addAll(data);
    var jsonEncoded = jsonEncode(_data);
    print(jsonEncoded);
    var _url = Uri.parse(url);
    final response =
        await http.post(_url, headers: _getHeader(), body: jsonEncoded);
    var responseJson = _returnResponse(response);
    return responseJson;
  }

  postWithLogedIn(String url, {Map<String, dynamic> data}) async {
    var jsonEncoded = jsonEncode(data);
    print(jsonEncoded);
    var _url = Uri.parse(url);
    final response =
        await http.post(_url, headers: _getLogedHeader(), body: jsonEncoded);
    var responseJson = _returnResponse(response);
    return responseJson;
  }

  Future<dynamic> getMethodAuthorized(String url,
      {Map<String, dynamic> data}) async {
    var responseJson;
    Uri uri = Uri.parse(url);
    final fullUrl = uri.replace(queryParameters: data);
    final response = await http.get(fullUrl, headers: _getLogedHeader());
    responseJson = _returnResponse(response);
    return responseJson;
  }

  static Map<String, String> _getLogedHeader() {
    // var box = Hive.box(PrefsKeys.boxUser);

    // return {
    //   'Content-Type': 'application/json',
    //   'Accept': '*/*',
    //   'Authorization': 'Bearer ${box.get(PrefsKeys.userToken)}'
    // };
  }

  static Map<String, String> _getHeader() {
    return {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 202:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 406:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 422:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw InternalServerError(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode} ${response.body}');
    }
  }
}
