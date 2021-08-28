import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/cart_function.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/model/cart_model.dart';
import 'package:myapp3/src/logic/res/res_order_cart.dart';
import 'package:myapp3/src/view/pages/auth/widgets/box_button.dart';
import 'package:myapp3/src/view/pages/cart/widgets/widget_cart.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';

import 'address_page.dart';

class CartView extends StatefulWidget {
  const CartView({Key key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final String image = "assets/images/7.png";

  void initState() {
    super.initState();
  }

  init() async {
    String token = Hive.box(EndBoxs.NaraApp).get("token");
    print("Token ff: $token");
    if (token == null) {
      // Getx.of(context).toGetNotBack(LoginScreen());
    }
  }

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
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int totalPrice = 0;
    var d = Hive.box(EndBoxs.CartItem);
    d.values.forEach((element) {
      totalPrice = totalPrice + (element.toMap()["totalPrice"] as int).toInt();
    });

    return Scaffold(
      // drawer:
      backgroundColor: Colors.grey[200],
      appBar: appBar(
        context: context,
        title: AppLocale.of(context).getTranslated("my_bag"),
        isCart: false,
      ),

      body: ValueListenableBuilder(
        valueListenable: Hive.box(EndBoxs.CartItem).listenable(),
        builder: (BuildContext context, Box value, Widget child) {
          return ListView.builder(
            itemCount: Hive.box(EndBoxs.CartItem).length,
            itemBuilder: (context, int index) {
              return WidgetCart(
                image: value.values.toList()[index].image,
                count: value.values.toList()[index].count.toString(),
                decrement: () {
                  setState(() {});

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
                  setState(() {});
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BoxButton(
                title: AppLocale.of(context).getTranslated("add_details_order"),
                busy: isLoading,
                disabled: isLoading,
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }

  get line =>
      Divider(thickness: 0.5, height: 1, color: Colors.black.withOpacity(0.4));

  void onTap() async {
    setState(() => isLoading = true);
    var box = Hive.box(EndBoxs.CartItem);
    if (box.values.length <= 0) {
      RouterF.of(context).message("خطأ", "السلة فارغة");
    } else {
      List<Map> orders = [];
      for (var i in box.values.toList()) {
        orders.add((i as CartItemModel).toMap());
      }

      var data = await ResOrderCart.setCart(map: CartFunction.init(orders));
      print(data);
      RouterF.of(context).push(() => AddressView());
    }
    setState(() => isLoading = false);
  }
}
