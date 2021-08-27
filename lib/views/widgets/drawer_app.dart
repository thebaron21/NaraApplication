import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/core/bloc/auth/authenticationo_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/controller/hive_box.dart';
import 'package:myapp3/main.dart';
import 'package:myapp3/views/pages/auth_screen/profile_page.dart';
import 'package:myapp3/views/pages/drawer/call_us_page.dart';
import 'package:myapp3/views/pages/drawer/chat_with_us_page.dart';
import 'package:myapp3/views/pages/drawer/quation_page.dart';
import 'package:myapp3/views/pages/drawer/order_page.dart';
import 'package:myapp3/views/pages/drawer/tv_page.dart';

import '../nara_app.dart';

buildCustome(context) {
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
                  if (listMenu(context)[index].onTap() is LanguagePage) {
                    String lang = hiveBox.boxNaraApp.get("lang");

                    String token = hiveBox.boxNaraApp.get("token");
                    if (lang == "en") {
                      await hiveBox.boxNaraApp.put("lang", "ar");
                      Getx.of(context).toGetNotBack(MyApp(
                        token: token,
                        locale: Locale('ar', ''),
                      ));
                    } else if (lang == "ar") {
                      await hiveBox.boxNaraApp.put("lang", "en");
                      Getx.of(context).toGetNotBack(MyApp(
                        token: token,
                        locale: Locale('en', ''),
                      ));
                    }
                  } else if (listMenu(context)[index].onTap != null) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => listMenu(context)[index].onTap(),
                      ),
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    line,
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

get line => Divider(thickness: 0.5, height: 0, color: Colors.white);

List<MeunList> listMenu(context) {
  return [
    MeunList(
      text: AppLocale.of(context).getTranslated("boutiqaat"),
      onTap: () => NaraApp(init: Nav.HOME),
    ),
    MeunList(
      text: AppLocale.of(context).getTranslated("celebrities"),
      onTap: () => NaraApp(init: Nav.CELEBRIES),
    ),
    MeunList(
      text: AppLocale.of(context).getTranslated("brands"),
      onTap: () => NaraApp(init: Nav.BRAND),
    ),
    MeunList(
      text: AppLocale.of(context).getTranslated("shop_by_category"),
      onTap: () => NaraApp(init: Nav.CATEGOIRES),
    ),
    MeunList(
        text: AppLocale.of(context).getTranslated("watchs"),
        onTap: () => TVPage()),
    MeunList(
      text: AppLocale.of(context).getTranslated("my_accountt"),
      onTap: () => BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: ProfilePage(),
      ),
    ),
    MeunList(
      text: AppLocale.of(context).getTranslated("call_us"),
      onTap: () => CallUsPage(),
    ),
    MeunList(
      text: AppLocale.of(context).getTranslated("my_order"),
      onTap: () => OrderPage(),
    ),
    MeunList(
      text: AppLocale.of(context).getTranslated("change_lang"),
      onTap: () => LanguagePage(),
    ),
    // MeunList(
    //   text: AppLocale.of(context).getTranslated("quatioins"),
    //   onTap: () => QuationsPage(),
    // ),
    MeunList(
      text: AppLocale.of(context).getTranslated("chat_with_us"),
      onTap: () => ChatWithUsPage(),
    ),
  ];
}

class LanguagePage extends Widget {
  @override
  Element createElement() {
    throw UnimplementedError();
  }
}


/*
SharedPreferences obj = await SharedPreferences.getInstance();
            if (listMenu(context)[index].onTap is LanguagePage) {
              var lang = obj.getString("lang");
              if (lang == null) {
                obj.setString("lang", "ar");
              }
              var token = obj.getString("token");
              if (lang == "en") {
                obj.setString("lang", "ar");
                Getx.of(context).toGetNotBack(MyApp(
                  token: token,
                  locale: Locale('${lang}', ''),
                ));
              } else if (lang == "ar") {
                obj.setString("lang", "en");
                Getx.of(context).toGetNotBack(MyApp(
                  token: token,
                  locale: Locale('${lang}', ''),
                ));
              }

              print("Language : $lang");
            } else if (listMenu(context)[index].onTap != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => listMenu(context)[index].onTap,
                ),
              );
            }

        */



// List<MeunList> listMenu(context) => [
//       MeunList(
//         icon: Icon(Icons.switch_account),
//         text: AppLocale.of(context).getTranslated("profile"), //"Profile",
//         onTap: BlocProvider(
//           create: (context) => AuthenticationBloc(),
//           child: ProfilePage(),
//         ),
//       ),
//       MeunList(
//           icon: Icon(Icons.list_alt),
//           text: AppLocale.of(context).getTranslated("my_order"),
//           onTap: OrderPage()),
//       MeunList(
//         icon: Icon(Icons.favorite),
//         text: AppLocale.of(context).getTranslated("menu_favorite"),
//         onTap: FavoritiesPage(),
//       ),
//       MeunList(
//           icon: Icon(Icons.info),
//           text: AppLocale.of(context).getTranslated("about_us"),
//           onTap: AboutUsPage()),
//       MeunList(
//         icon: Icon(Icons.language),
//         text: AppLocale.of(context).getTranslated("change_lang"),
//         onTap: LanguagePage(),
//       ),
//       MeunList(
//         icon: Icon(Icons.contact_phone),
//         text: AppLocale.of(context).getTranslated("call_us"),
//         onTap: CallUsPage(),
//       )
//     ];
