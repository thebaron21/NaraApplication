import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/complainats_model.dart';
import 'package:myapp3/core/response/message_response.dart';
import 'package:myapp3/views/nara_app.dart';
import 'package:myapp3/views/pages/auth_screen/login_screen.dart';
import 'package:myapp3/views/widgets/row_product.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';

import 'chat_with_us_page.dart';

class CallUsPage extends StatefulWidget {
  const CallUsPage({Key key}) : super(key: key);

  @override
  _CallUsPageState createState() => _CallUsPageState();
}

class _CallUsPageState extends State<CallUsPage> {
  MessageResponse _response;
  @override
  void initState() {
    super.initState();
    _response = MessageResponse();
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocale.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: t.getTranslated("call_us"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _infoContact(size),
          ],
        ),
      ),
    );
  }

  /// [UI]
  // void _launchURL(url) async =>
  //   await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  final Uri facebook = Uri(
    scheme: 'https',
    path: 'www.facebook.com/appnara-105088655218455',
  );


  final Uri instagram =
      Uri(scheme: 'http', path: 'ww.instagram.com/app.nara?r=nametag ');

  _infoContact(Size size) {
    return Container(
      width: size.width,
      child: Column(
        children: [
          InkWell(
            child: _row("Email", _text("support@nara.com")),
            onTap: () async {
              await launch("mailto:support@nara.com");
            },
          ),
          // _row("Phone", _text("+9000000000000")),
          _row(
              "Chat with Us",
              InkWell(
                child: _widget("Live Chat"),
                onTap: () {
                  Getx.of(context).toGet(ChatWithUsPage());
                },
              )),
          _row("Follw Us", _widgetRow()),
          _chatWidthUsByWhatsapp(size),
          _contentChat(size),
          _btnSend(size),
        ],
      ),
    );
  }

  _row(key, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [Text(key), SizedBox(width: 20), value],
      ),
    );
  }

  _text(String value, {color = Colors.black}) => Text(
        value,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: color,
        ), 
      );
  _widget(value) => Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: _text(value, color: Colors.white),
      );

  _widgetRow() {
    return Row(children: [
      // _circle(CIcon(IconMoon.icon_whatsapp, size: 20)),
      // SizedBox(width: 5),
      InkWell(
        onTap:()async{

        },
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

  _circle(c) {
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

  _chatWidthUsByWhatsapp(Size size) {
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

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController commit = TextEditingController();
  _contentChat(size) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  _designTextField(size, TextEditingController conn, String s,
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

  _btnSend(Size size) {
    return InkWell(
      onTap: () async {
        String token = Hive.box(Boxs.NaraApp).get("token");
        if (token != null) {
          var data = await _response.setComplainats(ComplainantsModel(
            name: name.text,
            email: email.text,
            phoneNumber: phone.text,
            comment: commit.text,
          ));
          if (data == true) {
            message("تم", "تمت الإرسال", context);
          } else {
            message("خطأ", "خطأ غير معروف", context);
          }
        } else {
          // message("خطأ", "قم بتسجيل دخول", context, isLogin: true);
        }
      },
      child: Container(
        width: size.width * 0.9,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        height: 50,
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: _text("إرسال", color: Colors.white),
      ),
    );
  }

  void message(String s, String t, BuildContext context,
      {bool isLogin = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(s),
          content: Text(t),
          actions: [
            FlatButton(
              child: Text("موفق"),
              onPressed: () async {
                print(isLogin);
                if (isLogin == false) {
                  String token = Hive.box(Boxs.NaraApp).get("token");
                  Getx.of(context).toGet(
                    NaraApp(
                      token: token,
                      init: Nav.HOME,
                    ),
                  );
                } else {
                  Getx.of(context).toGet(LoginScreen());
                }
              },
            ),
          ],
        );
      },
    );
  }
}
