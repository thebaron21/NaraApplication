import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/brand_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/brand_model.dart';
import 'package:myapp3/core/repoitorites/brand_repository.dart';
import 'package:myapp3/core/response/brand_response.dart';
import 'package:myapp3/views/pages/brands/product_brand.dart';
import 'package:myapp3/views/pages/favorities/favorities_page.dart';
import 'package:myapp3/views/widgets/row_product.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({Key key}) : super(key: key);

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  BrandResponse obj = BrandResponse();

  @override
  void initState() {
    super.initState();
    obj.getBrandOnce();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   obj.close3();
  // }

  SearchBar searchBar;
  String nameSearch;

  _BrandPageState() {
    searchBar = SearchBar(
      setState: setState,
      inBar: false,
      onChanged: (value) {
        obj.getBrandOnce(name: value);
      },
      onSubmitted: (value){
        obj.getBrandOnce();
      },
      onCleared: (){
        obj.getBrandOnce();
      },
      onClosed: (){
        obj.getBrandOnce();
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: searchBar.build(context),
        backgroundColor: Colors.white,
        body: StreamBuilder<BrandRepository>(
          stream: obj.getBrandOnceC.stream,
          builder:
              (BuildContext context, AsyncSnapshot<BrandRepository> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.brands.length > 0 &&
                  snapshot.data.error == "") {
                return _buildListView(snapshot.data.brands, size);
              } else {
                return _buildError(snapshot.data.error);
              }
            } else if (snapshot.hasError) {
              return _buildError(snapshot.error);
            } else {
              return _buildLoading();
            }
          },
        ),);
  }

  Widget _buildListView(List<BrandModel> brands, Size size) {
    return ListView.builder(
      itemCount: brands.length,
      itemBuilder: (BuildContext context, int index) {
        return cardTile(brands[index], size);
      },
    );
  }

  Widget cardTile(BrandModel brand, Size size) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.07,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () {
          Getx.of(context).toGet(BrandProductPage(
            model: brand,
          ));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                width: size.width * 0.1,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(brand.image)),
                ),
              ),
              SizedBox(width: 20),
              Container(
                color: Colors.grey,
                height: size.height * 0.05,
                width: 1,
              ),
              SizedBox(width: 20),
              Text(
                brand.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Text(" "),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.teal,
      ),
    );
  }
}
