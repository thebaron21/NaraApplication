import 'dart:convert';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/end_point_path.dart';
import 'package:http/http.dart' as http;
import 'package:myapp3/core/repoitorites/my_order_repository.dart';
import 'package:myapp3/core/repoitorites/order_repository.dart';
import 'package:dio/dio.dart';

class OrderResponse {
  Dio _dio = Dio();
  // ignore: missing_return
  Future<bool> setCart(var map) async {
    try {
      String token = Hive.box(Boxs.NaraApp).get("token");
      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var fromData = FormData.fromMap(map);

      var _response = await _dio.post(EndPointPath.addCartUrl,
          data: fromData, options: Options(headers: headers));
      if (_response.statusCode == 200) {
        return true;
      }
    } on SocketException catch (e) {
      print(e.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<MyOrderRespoitory> getOrder() async {
    try {
      String token = Hive.box(Boxs.NaraApp).get("token");
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var _response = await _dio.get(EndPointPath.myOrdersUrl,
          options: Options(headers: headers));
      var data = _response.data;
      if (_response.statusCode == 200) {
        if (data["statusCode"] == 200) {
          return MyOrderRespoitory.fromJson(data["data"]["data"]);
        } else {
          return MyOrderRespoitory.withError(data);
        }
      } else {
        return MyOrderRespoitory.withError(_response.statusCode);
      }
    } on SocketException catch (e) {
      print(e);
      return MyOrderRespoitory.withError("Not Connection");
    } catch (e) {
      print(e.toString());
      return MyOrderRespoitory.withError(e.toString());
    }
  }

  Future setOrder(addressId, paymentType) async {
    try {
      String token = Hive.box(Boxs.NaraApp).get("token");

      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
//      {
//     "data": "https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&token=EC-2B7274554A458971D",
//     "statusCode": 200
// }

      var _response = await http.post(
        Uri.parse(EndPointPath.checkout),
        body: {"address_id": addressId.toString(), "payment_type": paymentType},
        headers: headers,
      );
      print(json.decode(_response.body));
      if (_response.statusCode == 200) {
        return true;
      }
    } on SocketException catch (e) {
      print(e.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future setOrderCredit(addressId, paymentType) async {
    try {
      String token = Hive.box(Boxs.NaraApp).get("token");

      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var _response = await http.post(
        Uri.parse(EndPointPath.checkout),
        body: {"address_id": addressId.toString(), "payment_type": paymentType},
        headers: headers,
      );
      print(json.decode(_response.body));
      var data = json.decode(_response.body);
      if (_response.statusCode == 200) {
        return data["data"];
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw Exception(e);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
