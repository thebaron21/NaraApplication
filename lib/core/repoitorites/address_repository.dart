import 'package:myapp3/core/model/address_model.dart';

class AddressRepository {
  AddressModel addressModel;
  String error;
  AddressRepository.fromMap(Map<String, dynamic> json)
      : addressModel = AddressModel.fromMap(json),
        error = "";

  AddressRepository.withError(e)
      : addressModel = null,
        error = e.toString();
}
