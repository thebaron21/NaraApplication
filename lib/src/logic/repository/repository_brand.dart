
import 'package:myapp3/src/logic/model/model_brand.dart';

class RepositoryBrand {
  List<ModelBrand> brands;

  RepositoryBrand.fromMap(var json)
      : brands = (json["data"] as List).map((e) => ModelBrand.fromJson(e)).toList();
}
