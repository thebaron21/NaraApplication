import 'package:flutter/material.dart';
import 'package:myapp3/core/model/product_model.dart';

class FavoritiesProduct extends ChangeNotifier {
  List<ProductModel> _listFavorities = [];

  void addItemToFavorities(ProductModel item){
    _listFavorities.add(item);
    notifyListeners();
  }

  void removeFromFavorities(ProductModel item) {
    _listFavorities.remove(item);
    notifyListeners();
  }

  // void addToPre(List<ProductModel> list) async {
  //   SharedPreferences obj = await SharedPreferences.getInstance();
  //   obj.getStringList("favorities",list);
  // } 

  List<ProductModel> get listProductsFavorities => _listFavorities;
}
