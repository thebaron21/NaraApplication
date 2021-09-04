import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/function/home_function.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_auth.dart';
import 'package:myapp3/src/view/app_nara.dart';
import 'package:myapp3/src/view/widgets/widget_drawer.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';
import 'package:myapp3/src/view/widgets/widget_network_image.dart';

import '../edit_profile.dart';

class WidgetProfile {
  static Widget _imageProfile(Size size, Map user, context) {
    return Center(
      child: Container(
        width: size.width,
        height: size.height * 0.25,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.withOpacity(0.5),
              Colors.teal.withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                onPressed: () async {
                  await Hive.box(EndBoxs.NaraApp).delete("token");
                  FacebookLogin _login = FacebookLogin();
                  bool isLogin = await _login.isLoggedIn;
                  if (isLogin == true) {
                    await _login.logOut();
                  }
                  GoogleSignIn _googleSignIn = GoogleSignIn();
                  bool isSignIn = await _googleSignIn.isSignedIn();
                  if (isSignIn == true) {
                    await _googleSignIn.signOut();
                    await _googleSignIn.disconnect();
                  }
                  RouterF.of(context).put(() => AppNara(init: Nav.HOME));
                },
                child: Text(
                  AppLocale.of(context).getTranslated("logout"),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user["image"]),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(400),
                child: WidgetNetWork(
                  image: user["image"],
                ),
              ),
            ),
            _sizeBetweenText(size),
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () {
                  RouterF.of(context).push(() => EidtProfileView(
                        user: user,
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocale.of(context).getTranslated("welcome")} ${user["name"]}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget build(context, Size size, superReload) {
    return StreamBuilder(
      stream: ResAuth.profile().asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data["data"]["image"]);
          return buildList(size, snapshot.data["data"], context);
        } else if (snapshot.hasError) {
          return WidgetFuture.error(context, superReload);
        } else {
          return WidgetFuture.loading();
        }
      },
    );
  }

  static Widget buildList(Size size, Map state, context) {
    return Column(
      children: [
        _imageProfile(
          size,
          state,
          context,
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                WidgetDrawer.line(),
            itemCount: WidgetDrawer.listMenu(context).length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  // SharedPreferences obj =
                  //     await SharedPreferences.getInstance();
                  // if (listMenu(context)[index].onTap is LanguagePage) {
                  //   var lang = obj.getString("lang");
                  //   var token = obj.getString("token");
                  //   if (lang == "en") {
                  //     obj.setString("lang", "ar");
                  //     Getx.of(context).toGetNotBack(MyApp(
                  //       locale: Locale('${lang}', ''),
                  //     ));
                  //   } else if (lang == "ar") {
                  //     obj.setString("lang", "en");
                  //     Getx.of(context).toGetNotBack(MyApp(
                  //       locale: Locale('${lang}', ''),
                  //     ));
                  //   }

                  //   print("Language : $lang");
                  // } else
                  if (WidgetDrawer.listMenu(context)[index].onTap != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            WidgetDrawer.listMenu(context)[index].onTap(),
                      ),
                    );
                  }
                },
                child: ListTile(
                  title: Text("${WidgetDrawer.listMenu(context)[index].text}"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// [Size] help Bwtween
  static get _sizeBetween =>
      (Size size) => SizedBox(height: size.height * 0.05);
  static get _sizeBetweenText =>
      (Size size) => SizedBox(height: size.height * 0.025);
}
