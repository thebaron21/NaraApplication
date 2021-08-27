import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/core/repoitorites/product_respoitory.dart';
import 'package:myapp3/core/response/categories_reponse.dart';
import 'package:myapp3/views/pages/favorities/favorities_page.dart';
import 'package:myapp3/views/pages/home/ui/product_ui.dart';
import 'package:myapp3/views/pages/product/product.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';

class CategoriesProducts extends StatefulWidget {
  final String index;
  final String name;
  const CategoriesProducts({Key key, this.index, @required this.name})
      : super(key: key);

  @override
  _CategoriesProductsState createState() => _CategoriesProductsState();
}

class _CategoriesProductsState extends State<CategoriesProducts> {
  @override
  void initState() {
    super.initState();
    print(widget.index);
    obj.getOnceProductFun(categoryID: widget.index ) ;
  }

  @override
  void dispose() {
    super.dispose();
    // obj.close2();
  }

  SearchBar searchBar;
  String nameSearch;
  CategoriesResponse obj = CategoriesResponse();

  _CategoriesProductsState() {
    searchBar = SearchBar(
      setState: setState,
      inBar: false,
      onChanged: (value) {
        print(value);
        obj.getOnceProductFun(name: value);
        setState(() => nameSearch = value);
      },
      onSubmitted: (value) {
        print(value);
      },
      buildDefaultAppBar: buildAppBar,
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        widget.name,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
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
        searchBar.getSearchAction(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildCustome(context),
      appBar: searchBar.build(context),
      body: StreamBuilder<ProductModelRespoitory>(
        stream: obj.getOnceProduct.stream,
        builder: (context, AsyncSnapshot<ProductModelRespoitory> state) {
          if (state.hasData) {
            if (state.data.error != null) {
              return _buildError(state.data.error);
            } else if (state.data.exception != null) {
              return _buildError(state.data.exception);
            } else {
              return _buildListView(state.data.products);
            }
          } else if (state.hasError) {
            return _buildError(state.error);
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  get line =>
      Divider(thickness: 0.5, height: 1, color: Colors.black.withOpacity(0.4));

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: kcPrimaryColor,
      ),
    );
  }

  Widget _buildListView(List<ProductModel> products) {
    if (products.length <= 0) {
      return Center(
        child: Container(
          child: Text('لا توجد منتجات ضمن القسم'),
        ),
      );
    } else {
      return GridView.builder(
        physics: ScrollPhysics(),
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CardProduct(
            model: products[index],
            image: products[index].image,
            price: "${products[index].price}",
            text: products[index].name,
            desc: products[index].desc,
            onBuy: () {
              //
              Getx.of(context).toGet(BlocProvider<CategoriesBloc>(
                create: (_) => CategoriesBloc(),
                lazy: false,
                child: ProductPage(
                  model: products[index],
                ),
              ));
            },
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2 / 3.5,
          crossAxisSpacing: 2 / 3,
          crossAxisCount: 2,
        ),
      );
    }
  }

  Widget _buildError(Object error) {
    return Center(
      child: Text("خطأ غير معروف"),
    );
  }
}
