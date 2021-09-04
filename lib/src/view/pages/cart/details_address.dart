import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';

import 'package:myapp3/src/logic/function/router_function.dart';

import 'package:myapp3/src/view/pages/auth/widgets/box_button.dart';


import 'payment_view.dart';
import 'widgets/widget_details.dart';

class AddressDetailsView extends StatefulWidget {
  const AddressDetailsView({Key key}) : super(key: key);

  @override
  _AddressDetailsViewState createState() => _AddressDetailsViewState();
}

class _AddressDetailsViewState extends State<AddressDetailsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int totalPrice = 0;
    var d = Hive.box(EndBoxs.CartItem);
    d.values.forEach((element) {
      totalPrice = totalPrice + (element.toMap()["totalPrice"] as int).toInt();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFF333333),
              width: size.width,
              height: size.height * 0.06,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocale.of(context).getTranslated("details_address"),
                      style: TextStyle(color: Colors.white)),
                  Text("2/3", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppLocale.of(context).getTranslated("details_address"),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            WidgetDetials.addressFuture(() => setState(() {}), size),
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              width: size.width * 0.9,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5, color: Color(0xFF333333).withOpacity(0.08))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocale.of(context).getTranslated("total_price"),
                  ),
                  Text("$totalPrice")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: BoxButton(
                title: AppLocale.of(context).getTranslated("add_details_payment"),
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }

  void onTap() {
    RouterF.of(context).push( () => PaymentView());
  }
}
