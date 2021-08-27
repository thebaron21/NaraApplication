import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp3/core/api/address_repo_impl.dart';
import 'package:myapp3/core/api/checkout_repo_impl.dart';
import 'package:myapp3/core/model/address_model.dart';
import 'package:myapp3/core/model/bank_model.dart';

class AddressPaymentProvider extends ChangeNotifier {
  AddressRepoImpl addressRepoImpl = AddressRepoImpl();
  ChecokoutRepoImpl checokoutRepoImpl = ChecokoutRepoImpl();
  bool result;
  bool addingAddress = false;
  List<AddressModel> listAddress;
  bool gettingAddress = false;
  int selectedAddressId;
  int selectedPaymentType;
  bool checkoutProgress = false;
  bool checkoutResult;
  File selectedImg;
  int deliveryFees;
  String paypalCheckoutResult;
  BankModel bankModel;

  setSelectedImg(File value) {
    selectedImg = value;
    notifyListeners();
  }

  setSelectedPayment(value) {
    selectedPaymentType = value;
    notifyListeners();
    getDeliveryFees(value);
  }

  getDeliveryFees(value) async {
    if (value == 0) {
      deliveryFees = await addressRepoImpl.getDeliveryFees(
          selectedAddressId.toString(), 'cash');
      notifyListeners();
    } else if (value == 1) {
      deliveryFees = await addressRepoImpl.getDeliveryFees(
          selectedAddressId.toString(), 'transfer');
      notifyListeners();
    } else {
      deliveryFees = await addressRepoImpl.getDeliveryFees(
          selectedAddressId.toString(), 'transfer');
      notifyListeners();
    }
  }

  setSelectedAddressID(value) {
    selectedAddressId = value;
    notifyListeners();
  }



  // Future<List<AddressModel>> getAddress() async {
  //   listAddress = await addressRepoImpl.getAddress();
  //   return listAddress;
  // }

  Future<bool> checkout(String paymentType, int addressId,
      {File img, String token}) async {
    checkoutProgress = true;
    notifyListeners();
    if (img == null)
      checkoutResult = await checokoutRepoImpl.excuteCheckout(
        paymentType,
        addressId,
      );
    else {
      checkoutResult = await checokoutRepoImpl.excuteTransferCheckout(
          paymentType, addressId, img, token);
    }
    checkoutProgress = false;
    notifyListeners();
    return checkoutResult;
  }

  Future<String> paypalCheckout(
      String paymentType, int addressId, String paymentMethod) async {
    checkoutProgress = true;
    notifyListeners();
    paypalCheckoutResult = await checokoutRepoImpl.excutePaypalCheckout(
        paymentType, addressId, paymentMethod);
    checkoutProgress = false;
    notifyListeners();
    return paypalCheckoutResult;
  }

  Future<BankModel> getBankAcounts() async {
    var result = await addressRepoImpl.getBankAcounts();
    bankModel = result;
    notifyListeners();
    if (result.statusCode == 200) {
      return result;
    } else {
      return null;
    }
  }
}
