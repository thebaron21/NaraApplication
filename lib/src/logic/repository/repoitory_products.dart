import 'package:myapp3/src/logic/model/product_model.dart';

class RepositoryProduct {
  List<ProductModel> products;
  List<ProductModel> product;

  RepositoryProduct.fromMap(var json)
      : products = (json["data"]["data"] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
  
  RepositoryProduct.from(var json)
      : products = (json as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
}
