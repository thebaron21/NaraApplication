import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/bloc/rxdartBloc/product_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/core/repoitorites/product_respoitory.dart';
import 'package:myapp3/core/response/categories_reponse.dart';
import 'package:myapp3/views/pages/favorities/favorities_page.dart';
import 'package:myapp3/views/pages/home/ui/product_ui.dart';
import 'package:myapp3/views/pages/product/product.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';
import 'package:myapp3/views/widgets/product_widget.dart';

class AllViewProducts extends StatefulWidget {
  final int categoryId;
  final String name;
  final String search;
  const AllViewProducts({Key key, this.categoryId, this.name, this.search})
      : super(key: key);

  @override
  _AllViewProductsState createState() => _AllViewProductsState();
}

class _AllViewProductsState extends State<AllViewProducts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  SearchBar searchBar;
  String nameSearch;

  _AllViewProductsState() {
    searchBar = SearchBar(
      setState: setState,
      inBar: false,
      onChanged: (value) {
        print(value);
        setState(() => nameSearch = value);
      },
      buildDefaultAppBar: buildAppBar,
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        AppLocale.of(context).getTranslated("celebrities"),
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

  CategoriesResponse _response = CategoriesResponse();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: buildCustome(context),
      appBar: searchBar.build(context),
      body: FutureBuilder<ProductModelRespoitory>(
        future: _response.getFilteredProducts(name: nameSearch),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<ProductModelRespoitory> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null &&
                snapshot.data.products.length > 0) {
              return _buildWidgetError(size, snapshot.data.error);
            } else if (snapshot.data.exception != null &&
                snapshot.data.error == null &&
                snapshot.data.products.length > 0) {
              return _buildWidgetException(size, snapshot.data.exception);
            } else {
              return _buildWidgetProducs(size, snapshot.data.products);
            }
          } else if (snapshot.hasError) {
            return _buildError(size, snapshot.error);
          } else {
            return _buildWidgetLoading(size);
          }
        },
      ),
    );
  }

  Widget _buildWidgetError(Size size, Map<String, dynamic> error) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: Center(
        child: Text(error.toString()),
      ),
    );
  }

  Widget _buildWidgetException(Size size, String exception) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: Center(
        child: Text(exception),
      ),
    );
  }

  Widget _buildError(Size size, Object error) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: Center(
        child: Text(error.toString()),
      ),
    );
  }

  Widget _buildWidgetLoading(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: kcPrimaryColor,
        ),
      ),
    );
  }

  _buildWidgetProducs(Size size, List<ProductModel> products) {
    return GridView.builder(
      physics: ScrollPhysics(),
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CardProduct(
          image: products[index].image,
          price: "${products[index].price} KWD",
          text: products[index].name,
          desc: products[index].desc,
          model: products[index],
          onBuy: () {
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
