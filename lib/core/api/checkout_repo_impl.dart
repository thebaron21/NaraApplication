import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp3/config/end_point_path.dart';

import 'api_base_helper.dart';

class ChecokoutRepoImpl {

  Future<bool> excuteCheckout(String paymentType, int addressId) async {
    var data = {'address_id': '$addressId', 'payment_type': '$paymentType'};
    var result = await ApiBaseHelper()
        .postWithLogedIn(EndPointPath.checkout, data: data);

    if (result['statusCode'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  excuteTransferCheckout(
      String paymentType, int addressId, File img, String token) async {
    var result;
    var uri = Uri.parse(EndPointPath.checkout);

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer ' + token;
    request.files
        .add(await http.MultipartFile.fromPath('payment_image', img.path));
    request.fields['address_id'] = addressId.toString();
    request.fields['payment_type'] = 'transfer';
    request.send().then((value) async {
      if (value.statusCode == 200) {
        result = true;
      } else {
        result = false;
      }
    });
    return result;
  }


  Future<String> excutePaypalCheckout(
      String paymentType, int addressId, String paymentMethod) async {
    var data = {
      'address_id': '$addressId',
      'payment_type': '$paymentType',
      'payment_method': paymentMethod
    };
    var result = await ApiBaseHelper()
        .postWithLogedIn(EndPointPath.checkout, data: data);
    if (result['statusCode'] == 200) {
      return result['data'];
    } else {
      return null;
    }
  }
  
}
