class CartFunction {


  static Map<String, dynamic> init(datas) {
    List<Map<String, dynamic>> jsons = [];
    Map<String, dynamic> map = {"cart": jsons};

    for (var i in datas) {
      int index = (i["count"] as int);
      for (int o = 0; o < index; o++) {
        jsons.add(i);
      }
    }
    return map;
  }
}
