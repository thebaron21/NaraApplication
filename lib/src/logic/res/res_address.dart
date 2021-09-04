import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../config/end_boxs.dart';
import '../config/end_point.dart';
import '../function/res_function.dart';

class ResAddress {
  static String _token = Hive.box(EndBoxs.NaraApp).get("token");

  static Future setAddrss(
      {String name,
      String address,
      String phone,
      String city,
      String state,
      String street}) async {
    try {
      var data = await ResFunction.postRes(
        url: EndPoint.addAddressUrl,
        headers: ResFunction.withToken(_token),
        body: {
          "name": name,
          "address": address,
          "phone": phone,
          "city": city,
          "state": state,
          "street": street,
        },
      );
      return data;
    } catch (e) {
      throw e;
    }
  }

  static Future getAddress() async {
    try {
      var data = await ResFunction.getRes(
        url: EndPoint.getAddressUrl,
        headers: ResFunction.withToken(_token),
      );
      return data;
    } catch (e) {
      return e;
    }
  }
}
