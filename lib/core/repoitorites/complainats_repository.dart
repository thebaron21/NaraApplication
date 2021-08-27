import 'package:myapp3/core/model/complainats_model.dart';

class ComplainatsRepository {
  ComplainantsModel complainats;
  String error;
  ComplainatsRepository.fromMap(Map<String, dynamic> json)
      : complainats =  ComplainantsModel.fromJson(json),
        error = "";

  ComplainatsRepository.withError(e)
      : complainats = null,
        error = e.toString();
}
