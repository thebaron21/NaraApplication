import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/res/res_address.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class WidgetDetials {
  static Widget addressFuture(superReload, Size size) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: size.width * 0.9,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
            )
          ],
        ),
        child: StreamBuilder(
            stream: ResAddress.getAddress().asStream(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return address(size, snapshot.data["data"], context);
              } else if (snapshot.hasError) {
                return WidgetFuture.error(context, superReload);
              } else {
                return WidgetFuture.loading();
              }
            }),
      ),
    );
  }

  static Widget _design(
      Size size, TextEditingController controller, String hint) {
    return Container(
      width: size.width,
      height: size.height * 0.06,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Color(0xFF333333).withOpacity(0.08))
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// [Size] => [Line]
  static get line => Divider(
        color: Colors.black.withOpacity(0.2),
        thickness: 0.5,
        height: 20,
      );

  static Widget _text(String text) => Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: Color(0xFF333333),
          fontSize: 17,
        ),
      );

  /// [logic]

  static Widget address(Size size, Map address, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: size.height * 0.04),
        _text(
            "${AppLocale.of(context).getTranslated("username")} :    ${address["name"]} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("address")} :    ${address["address"]} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("city")}     :    ${address["city"]} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("state")} :    ${address["state"]} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("street")}  :    ${address["street"]} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("phone_number")} : ${address["phone"]} "),
      ],
    );
  }
}
