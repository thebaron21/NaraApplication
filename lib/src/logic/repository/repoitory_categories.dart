

import 'package:myapp3/src/logic/model/model_categories.dart';

class RespoitoryCategories {
  List<ModelCategory> categories;

  RespoitoryCategories.fromMap(Map<String, dynamic> json)
      : categories = (json["data"]["data"] as List).map((e) => ModelCategory.fromJson(e)).toList();
}
