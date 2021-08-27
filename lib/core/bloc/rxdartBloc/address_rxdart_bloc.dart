import 'package:myapp3/core/model/address_model.dart';
import 'package:myapp3/core/repoitorites/address_repository.dart';
import 'package:myapp3/core/response/address_reponse.dart';
import 'package:rxdart/rxdart.dart';

class AddressRxdartBloc {
  AddressResponse _response = AddressResponse();

  BehaviorSubject<bool> _setSubject = BehaviorSubject<bool>();
  BehaviorSubject<AddressRepository> _getSubject =
      BehaviorSubject<AddressRepository>();

  setAddress(AddressModel model) async {
    var data = await _response.setAddress(model);
    if (_setSubject.isClosed == false) _setSubject.sink.add(data);
  }

  getAddress() async {
    var data = await _response.getAddress();
    if (_getSubject.isClosed == false) _getSubject.sink.add(data);
  }

  close() {
    if (_setSubject.isClosed == false) _setSubject.close();
    if (_getSubject.isClosed == false) _getSubject.close();
  }

  BehaviorSubject<bool> get setSubject => _setSubject;
  BehaviorSubject<AddressRepository> get getsubject => _getSubject;
}

final addressRxdartBloc = AddressRxdartBloc();
