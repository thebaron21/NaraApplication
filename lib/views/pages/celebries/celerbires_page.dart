import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/bloc/rxdartBloc/celebrities_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/celebrity_model.dart';
import 'package:myapp3/core/repoitorites/celebrity_repoitory.dart';
import 'package:myapp3/core/response/categories_reponse.dart';
import 'package:myapp3/views/pages/categories/categories_product.dart';
import 'package:myapp3/views/pages/favorities/favorities_page.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';
import 'package:myapp3/views/widgets/network_widget.dart';

class CelerbiresPage extends StatefulWidget {
  const CelerbiresPage({Key key}) : super(key: key);

  @override
  _CelerbiresPageState createState() => _CelerbiresPageState();
}

class _CelerbiresPageState extends State<CelerbiresPage> {
  CategoriesResponse _celebritiesResponse = CategoriesResponse();

  @override
  void initState() {
    super.initState();
    _celebritiesResponse.getCelebritOnce();
  }

  @override
  void dispose() {
    super.dispose();
    // _celebritiesResponse.close();
  }

  SearchBar searchBar;
  String nameSearch;

  _CelerbiresPageState() {
    searchBar = SearchBar(
      setState: setState,
      inBar: false,
      onChanged: (value) {
        print(value);
        _celebritiesResponse.getCelebritOnce(name: value);
      },
      onClosed: (){
        _celebritiesResponse.getCelebritOnce();
      },
      onSubmitted: (value) {
       _celebritiesResponse.getCelebritOnce(name: value);
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: buildCustome(context),
      appBar: searchBar.build(context),
      body: StreamBuilder<CelebrityRepoitory>(
        stream: _celebritiesResponse.getOnce.stream,
        // ignore: missing_return
        builder: (BuildContext context, state) {
          if (state.hasData) {
            if (state.data.celebrity.length <= 0 &&
                state.data.error == null &&
                state.data.exception != null) {
              return Center(child: Text(state.data.error.toString()));
            } else if (state.data.celebrity.length <= 0 &&
                state.data.exception != null &&
                state.data.error == null) {
              return Center(child: Text(state.data.exception.toString()));
            } else {
              return doneOfList(state.data.celebrity, size);
            }
          } else if (state.hasError) {
            return Center(child: Text(state.error.toString()));
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: kcPrimaryColor,
              ),
            );
          }
        },
      ),
    );
  }

  doneOfList(List<Celebrity> data, size) {
    return Container(
      // height: size.height * 0.6,
      width: size.width,
      child: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return doneOfModel2(size, data[index], index);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }

  doneOfModel2(Size size, Celebrity data, int index) {
    return InkWell(
      onTap: () {
        Getx.of(context).toGet(
          BlocProvider<CategoriesBloc>(
            create: (_) => CategoriesBloc(),
            lazy: false,
            child: CategoriesProducts(
              name: data.name,
              index: index.toString(),
            ),
          ),
        );
      },
      child: Container(
        width: size.width * 0.35,
        margin: EdgeInsets.all(5),
        height: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Expanded(
              child: CustomeNetWork(
                image: data.image,
              ),
            ),
            Text(
              data.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
