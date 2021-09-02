import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as p;

import 'src/view/app_nara.dart';
import 'src/logic/config/LocaleLang.dart';
import 'src/logic/config/end_boxs.dart';
import 'src/logic/config/pallete.dart';
import 'src/logic/model/cart_model.dart';
import 'src/logic/model/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pathProvider = await p.getApplicationDocumentsDirectory();
  Hive.init(pathProvider.path);

  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());

  await Hive.openBox(EndBoxs.NaraApp);
  // await Hive.openBox(EndBoxs.CartItem);

  var initNaraApp = Hive.box(EndBoxs.NaraApp);

  String lang = initNaraApp.get("lang");
  Locale _locale = Locale('$lang', '');

  runApp(
    MyApp(
      locale: _locale,
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  Locale locale;

  MyApp({Key key, this.locale}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: Locale('ar', ''),
      supportedLocales: [
        Locale('ar', ''),
        Locale('ar', ''),
      ],
      title: 'Nara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(color: Colors.black),
        bottomAppBarTheme: BottomAppBarTheme(),
      ),
      color: kcPrimaryColor,
      home: FutureBuilder(
        future: Hive.openBox(EndBoxs.CartItem),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
              future: Hive.openBox(EndBoxs.FavoritiesBox),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FutureBuilder(
                    future: Future.delayed(Duration(seconds: 7)),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting ? Splash(): AppNara();
                    }
                  );
                } else {
                  return Scaffold();
                }
              },
            );
          } else {
            return Scaffold();
          }
        },
      ),
    );
  
  }
}


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main.gif"),
            fit: BoxFit.fill,
          ),
        ),
          
      ),
    );
  }
}
