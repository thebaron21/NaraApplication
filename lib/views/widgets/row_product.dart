import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/controller/favorites_product.dart';
import 'package:myapp3/core/controller/hive_box.dart';
import 'package:myapp3/views/pages/favorities/favorities_page.dart';
import 'package:provider/provider.dart';

import '../nara_app.dart';

Widget row(
    {@required String text,
    @required String viewAll,
    @required Function onTap}) {
  return Row(
    children: [
      SizedBox(
        width: 10,
      ),
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(height: 0.5, color: Colors.black.withOpacity(0.8)),
      ),
      SizedBox(
        width: 1,
      ),
      // ignore: deprecated_member_use
      FlatButton(
        onPressed: onTap,
        child: Text(viewAll),
      ),
    ],
  );
}

Widget appBar(
    {bool centerTitle = false,
    bool isLogo = false,
    String title,
    BuildContext context,
    Function onTap,
    bool isCart = false}) {
  Provider.of<FavoritiesProduct>(context, listen: false);
  return AppBar(
    centerTitle: centerTitle,
    title: isLogo == true
        ? Container(
            width: 70,
            height: 70,
            child: Center(
              child: Image.asset('assets/images/nara logo-09.png'),
            ),
          )
        : Text(title, style: TextStyle(color: Colors.black)),
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    automaticallyImplyLeading: true,
    actions: [
      IconButton(
        icon: ValueListenableBuilder(
          valueListenable: Hive.box(Boxs.FavoritiesBox).listenable(),
          builder: (BuildContext context, Box value, Widget child) {
            return Badge(
              badgeColor: kcPrimaryColor,
              badgeContent: Text(
                "${value.length}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.favorite_outline,
                color: Colors.black,
              ),
            );
          },
        ),
        onPressed: () {
          Getx.of(context).toGet(FavoritiesPage());
        },
      ),
      isCart == false
          ? IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: onTap,
            )
          : FlatButton(
              child: ValueListenableBuilder(
                valueListenable: Hive.box(Boxs.CartItem).listenable(),
                builder:
                    (BuildContext context, Box<dynamic> value, Widget child) {
                  return Badge(
                    badgeColor: kcPrimaryColor,
                    badgeContent: Text(
                      "${value.length}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: Image.asset(
                      "assets/icons/shopping-cart.png",
                      width: 24,
                      height: 24,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              onPressed: () {
                Getx.of(context).toGet(NaraApp(
                  init: Nav.MYBAD,
                ));
              },
            ),
    ],
  );
}
