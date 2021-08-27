import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'dart:math';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/controller/cart_shopping.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/logic/cart_logic.dart';
import 'package:myapp3/core/model/cart_model.dart';
import 'package:myapp3/core/response/address_reponse.dart';
import 'package:myapp3/core/response/order_response.dart';
import 'package:myapp3/views/pages/auth_screen/login_screen.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';
import 'package:provider/provider.dart';
import 'package:myapp3/views/widgets/network_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'address_page.dart';
part 'cart_shopping_widget.dart';

class ControllerTokenApp {
  StreamController<String> _controllerTokenApp =
      StreamController<String>.broadcast();
  Stream<String> get getControllerTokenApp => _controllerTokenApp.stream;
  StreamSink<String> get setControllerTokenApp => _controllerTokenApp.sink;

  ControllerTokenApp() {
    init();
  }

  init() async {
    var _refs = await SharedPreferences.getInstance();
    String token = _refs.getString("token");
    setControllerTokenApp.add(token);
  }

  void close() {
    _controllerTokenApp.close();
    setControllerTokenApp.close();
  }
}

class CartShopping extends StatefulWidget {
  const CartShopping({Key key}) : super(key: key);

  @override
  _CartShoppingState createState() => _CartShoppingState();
}

class _CartShoppingState extends State<CartShopping> {
  final String image = "assets/images/7.png";
  ControllerTokenApp _controllerTokenApp;
  Cart _cart;
  String token;

  void initState() {
    super.initState();

    init();
  }

  init() async {
    String token = Hive.box(Boxs.NaraApp).get("token");
    print("Token ff: $token");
    if (token == null) {
      Getx.of(context).toGetNotBack(LoginScreen());
    }
  }

  OrderResponse _response = OrderResponse();

  Random _random = Random();
  List<Color> colors = [
    Colors.teal,
    Colors.redAccent,
    Colors.amber,
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.green,
    Colors.cyan,
    Colors.brown,
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int totalPrice = 0;
    var d = Hive.box(Boxs.CartItem);
    d.values.forEach((element) {
      totalPrice = totalPrice + (element.toMap()["totalPrice"] as int).toInt();
    });
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
          drawer: buildCustome(context),
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              AppLocale.of(context).getTranslated("my_bag"),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: ValueListenableBuilder(
            valueListenable: Hive.box(Boxs.CartItem).listenable(),
            builder: (BuildContext context, Box value, Widget child) {
              return ListView.builder(
                itemCount: Hive.box(Boxs.CartItem).length,
                itemBuilder: (context, int index) {
                  return CartProduct(
                    image: value.values.toList()[index].image,
                    count: value.values.toList()[index].count.toString(),
                    decrement: () {
                      setState((){});
                      
                      CartItemModel data = value.values.toList()[index];
                      if (data.count > 1) {
                        data.count = data.count - 1;
                        data.totalPrice = (data.price * data.count);
                        value.putAt(index, data);
                      } else {
                        value.deleteAt(index);
                      }
                    },
                    increment: () {
                      setState((){});
                      CartItemModel data = value.values.toList()[index];
                      data.count = data.count + 1;
                      data.totalPrice = data.price * data.count;
                      value.putAt(index, data);
                    },
                    name: value.values.toList()[index].name,
                    price: value.values.toList()[index].totalPrice.toString(),
                  );
                },
              );
            },
          ),
          bottomSheet: Container(
            height: size.height * 0.16,
            child: Column(
              children: [
                Container(
                  width: size.width * 0.95,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(
                    //     color: Colors.black.withOpacity(0.4), width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$totalPrice"),
                      Text(AppLocale.of(context).getTranslated("total_price")),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var box = Hive.box(Boxs.CartItem);
                    if (box.values.length <= 0) {
                      Getx.of(context).message("خطأ", "السلة فارغة");
                    } else {
                      List<Map> orders = [];
                      for (var i in box.values.toList()) {
                        orders.add((i as CartItemModel).toMap());
                      }
                      CartLogic logic = CartLogic(orders);
                      var d = logic.init();
                      print(d);
                      var response = await _response.setCart(d);
                      if (response == true)
                        Getx.of(context).toGet(AddressPage());
                      else
                        Getx.of(context).message("خطأ", "خطأ غير معروف");
                    }
                  },
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.065,
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    decoration: BoxDecoration(
                      color: kcPrimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocale.of(context).getTranslated("add_details_order"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  get line =>
      Divider(thickness: 0.5, height: 1, color: Colors.black.withOpacity(0.4));
}
