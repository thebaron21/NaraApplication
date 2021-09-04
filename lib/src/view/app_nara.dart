import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/view/pages/auth/login_view.dart';
import 'package:myapp3/src/view/pages/brand/brand_view.dart';
import 'package:myapp3/src/view/pages/celebrities/celebrities_view.dart';
import '../logic/function/home_function.dart';
import 'pages/cart/cart_view.dart';
import 'pages/categories/categories_view.dart';
import 'pages/home/home_view.dart';

class AppNara extends StatefulWidget {
  final Nav init;
  const AppNara({Key key, this.init}) : super(key: key);

  @override
  _AppNaraState createState() => _AppNaraState();
}

class _AppNaraState extends State<AppNara> {
  ControllerAppNara obj;
  int indexItem = 0;

  var token;
  @override
  void initState() {
    super.initState();
    obj = ControllerAppNara();
  }

  @override
  void dispose() {
    super.dispose();
    obj.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Nav>(
        initialData: widget.init == null ? Nav.HOME : widget.init,
        stream: obj.getControllerAppNara,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<Nav> snapshot) {
          switch (snapshot.data) {
            case Nav.HOME:
              return HomeView();
              break;
            case Nav.CATEGOIRES:
              return CategoriesView();
              break;
            case Nav.BRAND:
              return BrandView();
              break;
            case Nav.MYBAD:
              return Hive.box(EndBoxs.NaraApp).get("token") != null
                  ? CartView()
                  : LoginView();
              break;
            case Nav.CELEBRIES:
              return CelebritiesView();
              break;
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          onTap: (index) {
            switch (index) {
              case 0:
                obj.setControllerAppNara.add(Nav.HOME);
                setState(() => indexItem = 0);
                break;
              case 1:
                obj.setControllerAppNara.add(Nav.BRAND);
                setState(() => indexItem = 1);
                break;
              case 2:
                obj.setControllerAppNara.add(Nav.CELEBRIES);
                setState(() => indexItem = 2);
                break;
              case 3:
                obj.setControllerAppNara.add(Nav.CATEGOIRES);
                setState(() => indexItem = 3);
                break;
              case 4:
                obj.setControllerAppNara.add(Nav.MYBAD);
                setState(() => indexItem = 4);
                break;
            }
          },
          currentIndex: indexItem,
          unselectedLabelStyle: TextStyle(fontSize: 10),
          selectedLabelStyle: TextStyle(fontSize: 10),
          backgroundColor: Color(0xFF333333),
          // fixedColor: Colors.white70,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/home-3.png",
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              label: AppLocale.of(context).getTranslated("home"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/brand.png",
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              label: AppLocale.of(context).getTranslated("brand"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/celebrities.png",
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              label: AppLocale.of(context).getTranslated("celebrities"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/categories.png",
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              label: AppLocale.of(context).getTranslated("categories"),
            ),
            BottomNavigationBarItem(
              icon: ValueListenableBuilder(
                valueListenable: Hive.box(EndBoxs.CartItem).listenable(),
                builder: (BuildContext context, Box value, Widget child) {
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
                      color: Colors.white,
                    ),
                  );
                },
              ),
              label: AppLocale.of(context).getTranslated("my_bag"),
            ),
          ],
        ),
      ),
    );
  }
}
