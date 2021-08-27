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

      /// Support Locale
      localeResolutionCallback: (currentLocale, supporedLocales) {
        if (currentLocale != null) {
          for (Locale locale in supporedLocales) {
            if (currentLocale.languageCode == locale.languageCode) {
              return currentLocale;
            }
          }
        }
        return supporedLocales.first;
      },
      title: 'Nara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(color: Colors.black),
        bottomAppBarTheme: BottomAppBarTheme(),
      ),
      color: kcPrimaryColor,
      home: FutureBuilder(
        future: Hive.openBox(EndBoxs.NaraApp),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
              future: Hive.openBox(EndBoxs.FavoritiesBox),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AppNara();
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
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (_) => AuthenticationBloc(),
    //     ),
    //     BlocProvider<CategoriesBloc>(
    //       create: (_) => CategoriesBloc(),
    //     )
    //   ],
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     localizationsDelegates: [
    //       AppLocale.delegate,
    //       GlobalMaterialLocalizations.delegate,
    //       GlobalWidgetsLocalizations.delegate,
    //     ],
    //     locale: widget.locale, // Default Locale
    //     supportedLocales: [
    //       Locale('ar', ''),
    //       Locale('en', ''),
    //     ],

    //     /// Support Locale
    //     localeResolutionCallback: (currentLocale, supporedLocales) {
    //       if (currentLocale != null) {
    //         for (Locale locale in supporedLocales) {
    //           if (currentLocale.languageCode == locale.languageCode) {
    //             return currentLocale;
    //           }
    //         }
    //       }
    //       return supporedLocales.first;
    //     },
    //     title: 'Nara',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //       iconTheme: IconThemeData(color: Colors.black),
    //       bottomAppBarTheme: BottomAppBarTheme(),
    //     ),
    //     color: kcPrimaryColor,
    //     home: FutureBuilder<Object>(
    //       future: Future.delayed(Duration(seconds: 7)),
    //       // ignore: missing_return
    //       builder: (context, snapshot) {
    //         return MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           localizationsDelegates: [
    //             AppLocale.delegate,
    //             GlobalMaterialLocalizations.delegate,
    //             GlobalWidgetsLocalizations.delegate,
    //           ],
    //           locale: widget.locale, // Default Locale
    //           supportedLocales: [
    //             Locale('ar', ''),
    //             Locale('en', ''),
    //           ],

    //           /// Support Locale
    //           localeResolutionCallback: (currentLocale, supporedLocales) {
    //             if (currentLocale != null) {
    //               for (Locale locale in supporedLocales) {
    //                 if (currentLocale.languageCode == locale.languageCode) {
    //                   return currentLocale;
    //                 }
    //               }
    //             }
    //             return supporedLocales.first;
    //           },
    //           title: 'Nara',
    //           theme: ThemeData(
    //             primarySwatch: Colors.blue,
    //             iconTheme: IconThemeData(color: Colors.black),
    //             bottomAppBarTheme: BottomAppBarTheme(),
    //           ),
    //           color: kcPrimaryColor,
    //           home: snapshot.connectionState == ConnectionState.waiting
    //               ? Splash()
    //               : FutureBuilder(
    //                   future: Hive.openBox(EndBoxs.NaraApp),
    //                   // ignore: missing_return
    //                   builder: (context, snapshot) {
    //                     if (snapshot.hasData) {
    //                       return FutureBuilder(
    //                         future: Hive.openBox(EndBoxs.FavoritiesBox),
    //                         builder: (context, snapshot) {
    //                           if (snapshot.hasData) {
    //                             return NaraApp(
    //                               token: widget.token,
    //                             );
    //                           } else {
    //                             return Scaffold();
    //                           }
    //                         },
    //                       );
    //                     } else {
    //                       return Scaffold();
    //                     }
    //                   },
    //                 ),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/splash/main.gif",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
