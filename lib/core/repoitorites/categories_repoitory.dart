
import 'package:myapp3/core/model/categories_model.dart';

class CategoriesRespoitory {
  List<CategoryModel> categories;
  Map<String, dynamic> error;
  String exception;

  CategoriesRespoitory.fromMap(Map<String, dynamic> json)
      : categories = (json["data"]["data"] as List).map((e) => CategoryModel.fromJson(e)).toList(),
        error = null,
        exception = null;

  CategoriesRespoitory.withError(var ex)
      : categories = List(),
        error = ex["errors"],
        exception = null;

  CategoriesRespoitory.withException(String ex)
      : categories = List(),
        error = null,
        exception = ex;
}
