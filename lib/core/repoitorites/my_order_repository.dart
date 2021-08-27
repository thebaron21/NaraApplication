import 'package:myapp3/core/model/order_model.dart';

class MyOrderRespoitory {
  final List<GetOrderModel> myorders;
  final String errors;

  MyOrderRespoitory.fromJson(var json)
      : myorders =
            (json as List).map((e) => GetOrderModel.fromJson(e)).toList(),
        errors = null;
  MyOrderRespoitory.withError(var error)
      : myorders = [],
        errors = error.toString();
}
