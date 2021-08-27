import 'package:flutter/material.dart';
import 'package:myapp3/core/model/cart_model.dart';

class Cart extends ChangeNotifier {
  List<CartItemModel> _list = [];

  int _totalPrice = 0;

  void addItem(CartItemModel item) {
    _list.add(item);

    _totalPrice += item.price;
    notifyListeners();
  }

  void remove(CartItemModel item) {
    _totalPrice -= item.totalPrice;
    _list.remove(item);
    notifyListeners();
  }

  void incrementCount(int index) {
    int price = _list[index].price;
    _list[index].count += 1;
    _list[index].totalPrice = price * _list[index].count;
    _totalPrice = _list[index].totalPrice;
    notifyListeners();
  }

  void decrementCount(int index) {
    int price = _list[index].price;
    if (_list[index].count == 1) {
      // _totalPrice -= _list[index].totalPrice;
      remove(_list[index]);
    } else {
      _list[index].count -= 1;
      _list[index].totalPrice -= price;
      _totalPrice -= price;
      print(_totalPrice);
    }
    notifyListeners();
  }

  int _allCount() {
    int len = 0;
    for (var o in _list) {
      len += o.count;
    }
    return len;
  }

  int _allPrice() {
    int price = 0;
    for (var i in _list) {
      price = price + (i.price * i.count);
    }
    return price;
  }

  int get totalPrice => _allPrice();

  int get deliveryPrice => totalPrice ~/ 4;

  int get total => totalPrice + deliveryPrice;
  int get conut => _list.length;

  List<CartItemModel> get basketItem => _list;

  int get allConut => _allCount();
}
