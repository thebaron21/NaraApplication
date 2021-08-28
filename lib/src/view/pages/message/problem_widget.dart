import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';

import 'message_view.dart';

class WidgetProblme {
  static Widget contentChat(size,
      {name, email, phone, commit, context, onTap}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoContact(size, onTap),
          _text(
            AppLocale.of(context).getTranslated("call_us"),
          ),
          _designTextField(size, name, "الاسم"),
          _designTextField(size, email, "البريد الإلكتروني"),
          _designTextField(size, phone, "رقم الهاتف"),
          _designTextField(size, commit, "التعليق", isBig: true),
        ],
      ),
    );
  }

  static Widget _designTextField(size, TextEditingController conn, String s,
      {bool isBig = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: isBig == false ? 50 : 150,
      child: TextField(
        minLines: isBig == true ? 2 : 1,
        maxLines: isBig == true ? 10 : 1,
        controller: conn,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: s,
        ),
      ),
    );
  }

  static Widget _infoContact(Size size, onTap) {
    return Builder(
      builder: (context) {
        return Container(
          width: size.width,
          child: Column(
            children: [
              InkWell(
                child: _row("Email", _text("support@nara.com")),
                onTap: () async {
                  // await launch("mailto:support@nara.com");
                },
              ),
              // _row("Phone", _text("+9000000000000")),
              _row(
                  "Chat with Us",
                  InkWell(
                    child: _widget("Live Chat"),
                    onTap: () {
                      RouterF.of(context).push(() => ChatWithUsView());
                    },
                  )),
              _row("Follw Us", _widgetRow()),
              _chatWidthUsByWhatsapp(size),
            ],
          ),
        );
      },
    );
  }

  static bool isLoading = false;
  static Widget btnSend(Size size, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: isLoading == false ? size.width * 0.9 : 100,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        height: 50,
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: isLoading == false
            ? _text("إرسال", color: Colors.white)
            : Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              )),
      ),
    );
  }

  static Widget _row(key, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [Text(key), SizedBox(width: 20), value],
      ),
    );
  }

  static Widget _text(String value, {color = Colors.black}) => Text(
        value,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      );
  static Widget _widget(value) => Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: _text(value, color: Colors.white),
      );

  static Widget _widgetRow() {
    return Row(children: [
      // _circle(CIcon(IconMoon.icon_whatsapp, size: 20)),
      // SizedBox(width: 5),
      InkWell(
        onTap: () async {},
        child: _circle(CIcon(IconMoon.icon_facebook2, size: 20)),
      ),
      SizedBox(width: 5),
      _circle(CIcon(IconMoon.icon_youtube, size: 20)),
      SizedBox(width: 5),
      _circle(
        CIcon(IconMoon.icon_twitter, size: 20),
      ),
      SizedBox(width: 5),
    ]);
  }

  static Widget _circle(c) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF333333), width: 2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: c,
    );
  }

  static Widget _chatWidthUsByWhatsapp(Size size) {
    return Container(
      height: 50,
      width: size.width,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_ios, color: Colors.white),
          Expanded(child: Container()),
          Text(
            "WhatsApp تحدث معنا مباشرة على ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 5),
          CIcon(IconMoon.icon_whatsapp, color: Colors.white)
        ],
      ),
    );
  }
}
