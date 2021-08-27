//<List<Product>>  ProductModel



import 'package:myapp3/core/model/product_model.dart';

class ProductModelRespoitory {
  List<ProductModel> products;
  Map<String, dynamic> error;
  String exception;

  ProductModelRespoitory.fromMap(Map<String, dynamic> json)
      : products = (json["data"]["data"] as List).map((e) => ProductModel.fromJson(e)).toList(),
        error = null,
        exception = null;

  ProductModelRespoitory.withError(var ex)
      : products = List(),
        error = ex["errors"],
        exception = null;

  ProductModelRespoitory.withException(String ex)
      : products = List(),
        error = null,
        exception = ex;
}
