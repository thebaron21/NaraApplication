
import 'package:myapp3/src/logic/model/model_celebrities.dart';

class RepositoryCelebrities {
  List<ModelCelebrity> celebrities;

  RepositoryCelebrities.fromMap(var json)
      : celebrities = (json["data"] as List)
            .map((e) => ModelCelebrity.fromJson(e))
            .toList();
}
