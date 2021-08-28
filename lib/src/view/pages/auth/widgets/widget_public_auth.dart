
import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';

import '../login_view.dart';

class WidgetAuthPublic{
  static Widget designTextField(Size size,
      {String hint, controller, bool password, Widget trailing}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 7),
          hintText: hint,
          suffix: trailing,
          border: InputBorder.none,
          // border: OutlineInputBorder(),
        ),
      ),
    );
  }

  static Widget alreadyIHave(context) {
    return FlatButton(
      onPressed: () {
        RouterF.of(context).push(() => LoginView());
      },
      child: Text(
        AppLocale.of(context).getTranslated("already_have"),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  static  Widget selectSex(Size size, int index, {Function onPressed,Function onPressed2,Function onPressed3}) {
    return Center(
      child: Container(
        width: size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[400].withOpacity(0.7),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  Text("Male"),
                  index == 1
                      ? Icon(Icons.check, color: kcAccentColor)
                      : Container(),
                ],
              ),
            ),
            FlatButton(
              minWidth: 70,
              onPressed: onPressed2,
              child: Row(
                children: [
                  Text("Female"),
                  index == 2
                      ? Icon(Icons.check, color: kcAccentColor)
                      : Container(),
                ],
              ),
            ),
            FlatButton(
              onPressed:onPressed3,
              child: Row(
                children: [
                  Text("Later"),
                  index == 3
                      ? Icon(Icons.check, color: kcAccentColor)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}