import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/view/pages/brand/widgets/widget_brands.dart';
import 'package:myapp3/src/view/pages/favorites/favorities_view.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';
import 'package:myapp3/src/view/widgets/widget_drawer.dart';

class BrandView extends StatefulWidget {
  @override
  _BrandViewState createState() => _BrandViewState();
}

class _BrandViewState extends State<BrandView> {
  SearchBar searchBar;
  String name;

  _BrandViewState() {
    searchBar = SearchBar(
      setState: setState,
      inBar: false,
      onChanged: (value) {
        setState(() => name = value);
      },
      onSubmitted: (value) {
        setState(() => name = null);
      },
      onCleared: () {
        setState(() => name = null);
      },
      onClosed: () {
        setState(() => name = null);
      },
      buildDefaultAppBar: buildAppBar,
    );
  }
  AppBar buildAppBar(context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        AppLocale.of(context).getTranslated("brand"),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
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
          onPressed: () {
             RouterF.of(context).push(() => FavoritiesView());
          },
        ),
        searchBar.getSearchAction(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       drawer: WidgetDrawer.drawer(context),
      appBar: searchBar.build(context),
      body: WidgetBrandView.brandsFuture(size, () => setState(() {}), name),
    );
  }
}
