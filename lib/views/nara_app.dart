import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:badges/badges.dart';
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/controller/cart_shopping.dart';
import 'package:provider/provider.dart';
import 'pages/auth_screen/login_screen.dart';
import 'pages/brands/brand_page.dart';
import 'pages/cart/cart_shopping.dart';
import 'pages/categories/categories.dart';
import 'pages/celebries/celerbires_page.dart';
import 'pages/home/home.dart';

enum Nav { HOME, CATEGOIRES, BRAND, MYBAD, CELEBRIES }

class ControllerNaraApp {
  StreamController<Nav> _controllerNaraApp = StreamController<Nav>.broadcast();
  Stream<Nav> get getControllerNaraApp => _controllerNaraApp.stream;
  StreamSink<Nav> get setControllerNaraApp => _controllerNaraApp.sink;

  ControllerNaraApp() {
    _controllerNaraApp.add(Nav.HOME);
  }
  void close() {
    _controllerNaraApp.close();
    setControllerNaraApp.close();
  }
}

class NaraApp extends StatefulWidget {
  final String token;
  final Nav init;
  const NaraApp({Key key, this.token, this.init}) : super(key: key);

  @override
  _NaraAppState createState() => _NaraAppState();
}

class _NaraAppState extends State<NaraApp> {
  ControllerNaraApp obj;
  int indexItem = 0;

  var token;
  @override
  void initState() {
    super.initState();
    obj = ControllerNaraApp();
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
        stream: obj.getControllerNaraApp,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<Nav> snapshot) {
          switch (snapshot.data) {
            case Nav.HOME:
              return Home();
              break;
            case Nav.CATEGOIRES:
              return CategoriesPage();
              break;
            case Nav.BRAND:
              return BrandPage();
              break;
            case Nav.MYBAD:
              return Hive.box(Boxs.NaraApp).get("token") != null
                  ? CartShopping()
                  : LoginScreen();
              break;
            case Nav.CELEBRIES:
              return Center(
                  child: BlocProvider(
                create: (context) => CategoriesBloc(),
                child: CelerbiresPage(),
              ));
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
                obj.setControllerNaraApp.add(Nav.HOME);
                setState(() => indexItem = 0);
                break;
              case 1:
                obj.setControllerNaraApp.add(Nav.BRAND);
                setState(() => indexItem = 1);
                break;
              case 2:
                obj.setControllerNaraApp.add(Nav.CELEBRIES);
                setState(() => indexItem = 2);
                break;
              case 3:
                obj.setControllerNaraApp.add(Nav.CATEGOIRES);
                setState(() => indexItem = 3);
                break;
              case 4:
                obj.setControllerNaraApp.add(Nav.MYBAD);
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
                valueListenable: Hive.box(Boxs.CartItem).listenable(),
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
