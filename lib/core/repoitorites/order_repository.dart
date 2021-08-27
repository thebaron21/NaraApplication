class OrderRepository {
  List<OrderModel> orders;
  String error;
  OrderRepository.fromJson(var json)
      : orders = (json as List).map((e) => OrderModel.fromJson(e)).toList(),
        error = "";

  OrderRepository.withError(error)
      : orders = List(),
        error = error.toString();
}

class OrderModel {
  final int id;

  OrderModel.fromJson(Map<String, dynamic> json) : id = json["id"] as int;

  toMap() => {
    "id" : id
  };
}
