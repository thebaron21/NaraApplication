import 'package:myapp3/config/end_point_path.dart';
import 'package:myapp3/core/model/bank_model.dart';

import 'api_base_helper.dart';

class AddressRepoImpl {
  // @override
  // Future<bool> addAddress(AddressJsonModel addressJsonModel) async {
  //   var result = await ApiBaseHelper().postWithLogedIn(
  //       EndPointPath.addAddressUrl,
  //       data: addressJsonModel.toJson());

  //   if (result['statusCode'] == 200) {
  //     return true;
  //   } else
  //     return false;
  // }


  // @override
  // Future<List<AddressModel>> getAddress() async {
  //   var result =
  //       await ApiBaseHelper().getMethodAuthorized(EndPointPath.getAddressUrl);
  //   var formattedJson = AddressResponseModel.fromJson(result);
  //   List<AddressModel> listOfAddress = [];
  //   if (formattedJson.statusCode == 200) {
  //     for (int i = 0; i < formattedJson.data.data.length; i++) {
  //       listOfAddress.add(formattedJson.data.data[i]);
  //     }
  //     return listOfAddress;
  //   } else {
  //     return [];
  //   }
  // }

  @override
  Future<int> getDeliveryFees(String addressID, String paymentType,
      {String paymentMethod}) async {
    var data;
    if (paymentMethod == null) {
      data = {'address_id': addressID, 'payment_type': paymentType};
    } else {
      data = {
        'address_id': addressID,
        'payment_type': paymentType,
        'payment_method': paymentMethod
      };
    }
    var result = await ApiBaseHelper()
        .getMethodAuthorized(EndPointPath.deliveryFeesUrl, data: data);

    if (result['statusCode'] == 200) {
      return int.parse(result['data']);
    } else {
      return null;
    }
  }

  @override
  Future<BankModel> getBankAcounts() async {
    var result =
        await ApiBaseHelper().getMethodAuthorized(EndPointPath.bankAcountUrl);
    var formattedJson = BankModel.fromJson(result);
    return formattedJson;
  }
}
