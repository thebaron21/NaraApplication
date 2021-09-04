import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/model/model_categories.dart';
import 'package:myapp3/src/view/pages/favorites/favorities_view.dart';
import 'widgets/widget_categories.dart';

class CategoriesProductView extends StatefulWidget {
  final ModelCategory category;

  const CategoriesProductView({Key key, this.category}) : super(key: key);
  @override
  _CategoriesProductViewState createState() => _CategoriesProductViewState();
}

class _CategoriesProductViewState extends State<CategoriesProductView> {
  SearchBar searchBar;
  String name;

  _CategoriesProductViewState() {
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
        widget.category.name,
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
      appBar: searchBar.build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WidgetCategoryView.producCategory(widget.category.id.toString(),
                () => setState(() {}), size, name),
          ],
        ),
      ),
    );
  }
}
