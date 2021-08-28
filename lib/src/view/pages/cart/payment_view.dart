import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_address.dart';
import 'package:myapp3/src/logic/res/res_order_cart.dart';
import 'package:myapp3/src/view/app_nara.dart';
import 'package:myapp3/src/view/pages/auth/widgets/box_button.dart';

import 'payment_page_view.dart';
import 'widgets/widget_details.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key key}) : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  /// [Data] of Radio
  String tPank = "pank";
  String tCredit = "credit";
  String paymentInRecive = "cash";

  String groupValue = "";
  _radio(String value) => Radio(
        value: value,
        groupValue: groupValue,
        onChanged: (v) => setState(() => groupValue = v),
      );
  _text(String text) => Text(
        text,
        style: TextStyle(fontSize: 18),
      );

  _bar(Size size) => Container(
        color: Color(0xFF333333),
        width: size.width,
        height: size.height * 0.06,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocale.of(context).getTranslated("select_type_payment"),
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "3/3",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  /// [Size] => [Line]
  get line => Divider(
        color: Color(0xFF333333).withOpacity(0.3),
        thickness: 0.5,
        height: 15,
      );

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocale.of(context).getTranslated("my_bag"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bar(size),
            SizedBox(height: 30),

            /// [Type Card]
            _typeCard(size),
            SizedBox(height: size.height * 0.05),
            _price(size),
            SizedBox(height: size.height * 0.05),
            WidgetDetials.addressFuture(() => setState(() {}), size),
            SizedBox(height: size.height * 0.025),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: BoxButton(
                busy: isLoading,
                onTap: onTap,
                disabled: isLoading,
                title:
                    AppLocale.of(context).getTranslated("add_details_payment"),
              ),
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }

  _typeCard(Size size) {
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFF333333).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(children: [
            _radio(tCredit),
            _text(
              AppLocale.of(context).getTranslated("credit_card"),
            )
          ]),
          line,
          Row(children: [
            _radio(paymentInRecive),
            _text(
              AppLocale.of(context).getTranslated("payment_to_recive"),
            ),
          ]),
        ],
      ),
    );
  }

  _price(Size size) {
    int totalPrice = 0;
    var d = Hive.box(EndBoxs.CartItem);
    d.values.forEach((element) {
      totalPrice = totalPrice + (element.toMap()["totalPrice"] as int).toInt();
    });
    return Container(
      width: size.width * 0.9,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFF333333).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _text(
                AppLocale.of(context).getTranslated("price"),
              ),
              _text("$totalPrice"),
            ],
          ),
          line,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _text(
                AppLocale.of(context).getTranslated("delivery"),
              ),
              _text("${30}"),
            ],
          ),
          line,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _text(
              AppLocale.of(context).getTranslated("total_price"),
            ),
            _text("${totalPrice + 30}"),
          ])
        ],
      ),
    );
  }

  // _address(Size size) {
  //   return Container(
  //     width: size.width * 0.9,
  //     // height: size.height * 0.55,
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(5),
  //       border: Border.all(color: Color(0xFF333333).withOpacity(0.3)),
  //       color: Colors.white,
  //     ),
  //     child: StreamBuilder<AddressRepository>(
  //       stream: addressRxdartBloc.getsubject.stream,
  //       builder:
  //           // ignore: missing_return
  //           (context, AsyncSnapshot<AddressRepository> snapshot) {
  //         if (snapshot.hasData) {
  //           if (snapshot.data.addressModel != null &&
  //               snapshot.data.error == "") {
  //             return _buildDataAddress(size, snapshot.data.addressModel);
  //           } else {
  //             return _buildError(snapshot.data.error);
  //           }
  //         } else if (snapshot.hasError) {
  //           return _buildError(snapshot.error);
  //         } else {
  //           return _buildLoading();
  //         }
  //       },
  //     ),
  //   );
  // }

  void onTap() async {
    setState(() => isLoading = true);
    var data = await ResAddress.getAddress();
    var idAddress = data["data"]["id"];
    if (groupValue == "cash") {
      var data = await ResOrderCart.setPayment(
        addressId: idAddress,
        paymentType: groupValue,
      );
      print(data);
      if (data != null) {
        RouterF.of(context).push(() => AppNara());
      } else {
        RouterF.of(context).message("خطأ", "خطأ غير معروف");
      }
    } else if (groupValue == "credit") {
      var data = await ResOrderCart.setPayment(
        addressId: idAddress,
        paymentType: "credit",
      );
      if (data != null)
        RouterF.of(context).push(() => WebViewPage(url: data["data"]));
      else
        RouterF.of(context).message("خطأ", "خطأ غير معروف");
    }
    setState(() => isLoading = false);
  }
}
