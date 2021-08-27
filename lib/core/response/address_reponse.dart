import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:myapp3/config/end_point_path.dart';
import 'package:myapp3/core/controller/hive_box.dart';
import 'package:myapp3/core/model/address_model.dart';
import 'package:myapp3/core/repoitorites/address_repository.dart';
import 'package:dio/dio.dart';

class AddressResponse {
  Dio _dio = Dio();
  // ignore: missing_return
  Future<bool> setAddress(AddressModel obj) async {
    try {
      String token = hiveBox.boxNaraApp.get("token");
      var headers = {'Authorization': 'Bearer $token'};

      var _response = await _dio.post(
        EndPointPath.addAddressUrl,
        data: obj.toMap(),
        options: Options(
          headers: headers,
        ),
      );
      var data = _response.data;
      print(data);
      if (data["statusCode"] == 200 && data["data"] == "تمت الإضافه بنجاح") {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (e) {
      print(e.toString());
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<AddressRepository> getAddress() async {
    try {
      String token = hiveBox.boxNaraApp.get("token");
      var headers = {'Authorization': 'Bearer $token'};

      http.Response _response = await http.get(
        Uri.parse(EndPointPath.getAddressUrl),
        headers: headers,
      );
      var data = json.decode(_response.body);
      print(data);
      if (_response.statusCode == 200) {
        if (data["statusCode"] == 200) {
          return AddressRepository.fromMap(data["data"]);
        }
      } else {
        return AddressRepository.withError(data.toString());
      }
    } on SocketException catch (e) {
      return AddressRepository.withError(e);
    } catch (e) {
      return AddressRepository.withError(e);
    }
  }
}
