import 'package:myapp3/core/model/brand_model.dart';

class BrandRepository {
  List<BrandModel> brands;
  String error;

  BrandRepository.fromMap(var json)
      : brands = (json as List).map((e) => BrandModel.fromMap(e)).toList(),
        error = "";

  BrandRepository.withError(ex)
      : brands = List(),
        error = ex.toString();
}

class BrandRepository2 {
  List<BrandModel2> brands;
  String error;

  BrandRepository2.fromMap(var json)
      : brands = (json as List).map((e) => BrandModel2.fromJson(e) ).toList(),
        error = "";

  BrandRepository2.withError(ex)
      : brands = [],
        error = ex.toString();
}
