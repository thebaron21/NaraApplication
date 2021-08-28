import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/config/pallete.dart';

Widget appBar(
    {bool centerTitle = false,
    bool isLogo = false,
    String title,
    BuildContext context,
    Function onTap,
    bool isCart = false}) {
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
          valueListenable: Hive.box(EndBoxs.FavoritiesBox).listenable(),
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
        onPressed: () {},
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
                valueListenable: Hive.box(EndBoxs.CartItem).listenable(),
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
              onPressed: () {},
            ),
    ],
  );
}
