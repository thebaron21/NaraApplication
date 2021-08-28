class GetOrderModel {
  final int id;
  final int price;
  final GetAddress address;
  final String deliveryFees;
  final String paymentType;
  final String paymenyStatus;
  final String statusValue;
  final String status;
  // final GetDetials details;

  GetOrderModel.fromJson(var json)
      : id = json["id"],
        price = json["price"],
        address = GetAddress.fromJson(json["address"]),
        deliveryFees = json["delivery_fees"],
        paymentType = json["payment_type"],
        statusValue = json["status_value"],
        paymenyStatus = json["payment_status"],
        status = json["status"];

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "delivery_fees": deliveryFees,
        "payment_type": paymentType,
        "paymeny_status": paymenyStatus,
        "status_value": statusValue,
        "status": status
      };
}

class GetAddress {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String city;
  final String state;
  final String street;

  GetAddress.fromJson(var json)
      : id = json["id"],
        name = json["name"],
        address = json["address"],
        phone = json["phone"],
        city = json["city"],
        state = json["state"],
        street = json["street"];
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "city": city,
        "state": state,
        "street": street
      };
}

class GetDetials {
  final String qty;
  final String price;
  final GetProduct products;

  GetDetials.fromJson(var json)
      : qty = json["qty"],
        price = json["price"],
        products = GetProduct.fromJson(json["product_details"]);
}

class GetProduct {
  final int id;
  final String image;
  final String name;
  final String price;
  final String desc;
  GetProduct.fromJson(var json)
      : id = json["id"],
        name = json["name"],
        image = json["image"],
        price = json["price"],
        desc = json["description"];
}
