import 'package:myapp3/src/logic/model/model_order.dart';

class RespoitoryMyOrder {
  final List<GetOrderModel> myorders;

  RespoitoryMyOrder.fromJson(var json)
      : myorders =
            (json as List).map((e) => GetOrderModel.fromJson(e)).toList();

}
