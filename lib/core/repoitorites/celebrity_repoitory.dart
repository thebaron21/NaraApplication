import 'package:myapp3/core/model/celebrity_model.dart';

class CelebrityRepoitory {
  List<Celebrity> celebrity;
  Map<String, dynamic> error;
  String exception;

  CelebrityRepoitory.fromMap(var json)
      : celebrity = (json["data"] as List).map((e) => Celebrity.fromJson(e)).toList(),
        error = null,
        exception = null;

  CelebrityRepoitory.withError(var ex)
      : celebrity = [],
        error = ex["errors"],
        exception = null;

  CelebrityRepoitory.withException(String ex)
      : celebrity = List(),
        error = null,
        exception = ex;
}
