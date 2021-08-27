import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/config/end_boxs.dart';
import 'package:myapp3/src/config/end_point.dart';
import 'package:myapp3/src/function/res_function.dart';

class ResOrderCart {
  static String _token = Hive.box(EndBoxs.NaraApp).get("token");

  static Future setCart({Map<String, dynamic> map}) async {
    try {
      var data = await ResFunction.postRes(
          url: EndPoint.addCartUrl,
          headers: ResFunction.withToken(_token),
          body: FormData.fromMap(map));
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future getOrder() async {
    try {
      var data = await ResFunction.getRes(
        url: EndPoint.myOrdersUrl,
        headers: ResFunction.withToken(_token),
      );
      return data;
    } catch (e) {
      return e;
    }
  }

  static Future setPayment({addressId, paymentType}) async {
    try {
      var data = await ResFunction.postRes(
          url: EndPoint.checkout,
          headers: ResFunction.withToken(_token),
          body: {
            "address_id": addressId,
            "payment_type": paymentType,
          });
      return data;
    } catch (e) {
      return e;
    }
  }
}
