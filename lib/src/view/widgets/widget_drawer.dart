import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/function/home_function.dart';
import 'package:myapp3/src/view/app_nara.dart';
import 'package:myapp3/src/view/pages/auth/profile_page.dart';
import 'package:myapp3/src/view/pages/message/message_view.dart';
import 'package:myapp3/src/view/pages/message/problem_view.dart';
import 'package:myapp3/src/view/pages/order/order_view.dart';

class WidgetDrawer {
  static Widget drawer(context) {
    return Container(
      width: 300,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              height: 30,
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: 30),
                  Text(
                    AppLocale.of(context).getTranslated("welcome"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: listMenu(context).length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    if (listMenu(context)[index].onTap != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              listMenu(context)[index].onTap(),
                        ),
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      line(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Text(
                          "${listMenu(context)[index].text}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  static Widget line() =>
      Divider(thickness: 0.5, height: 0, color: Colors.white);

  static List<MeunListDrawer> listMenu(context) {
    return [
      MeunListDrawer(
        text: AppLocale.of(context).getTranslated("boutiqaat"),
        onTap: () => AppNara(init: Nav.HOME),
      ),
      MeunListDrawer(
        text: AppLocale.of(context).getTranslated("celebrities"),
        onTap: () => AppNara(init: Nav.CELEBRIES),
      ),
      MeunListDrawer(
        text: AppLocale.of(context).getTranslated("brands"),
        onTap: () => AppNara(init: Nav.BRAND),
      ),
      MeunListDrawer(
        text: AppLocale.of(context).getTranslated("shop_by_category"),
        onTap: () => AppNara(init: Nav.CATEGOIRES),
      ),
      MeunListDrawer(
        text: AppLocale.of(context).getTranslated("my_accountt"),
        onTap: () => ProfileView(),
      ),
      MeunListDrawer(
        text: AppLocale.of(context).getTranslated("call_us"),
        onTap: () => CallUsView(),
      ),
      MeunListDrawer(
        text: AppLocale.of(context).getTranslated("my_order"),
        onTap: () => OrderView(),
      ),
      MeunListDrawer(
        text: AppLocale.of(context).getTranslated("chat_with_us"),
        onTap: () => ChatWithUsView(),
      ),
    ];
  }
}

class LanguagePage extends Widget {
  @override
  Element createElement() {
    throw UnimplementedError();
  }
}

class MeunListDrawer {
  final String text;
  final Function onTap;

  MeunListDrawer({this.onTap, this.text});
}
