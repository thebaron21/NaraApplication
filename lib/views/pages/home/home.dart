import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/core/bloc/auth/authenticationo_bloc.dart';
import 'package:myapp3/views/pages/auth_screen/profile_page.dart';
import 'package:myapp3/views/pages/celebries/celerbires_page.dart';
import 'package:myapp3/views/pages/favorities/favorities_page.dart';
import 'package:myapp3/views/pages/product/products.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';
import 'package:myapp3/views/widgets/row_product.dart';
import 'ui/category_card.dart';
import 'ui/celebrities_ui.dart';
import 'ui/product_ui.dart';
import 'ui/slider_ui.dart';
import 'ui/top_brand_ui.dart';
import 'ui/top_categories_ui.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: buildCustome(context),
      appBar: appBar(
        centerTitle: true,
        isLogo: true,
        context: context,
        isCart: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SliderUI(),
            row(
              viewAll: AppLocale.of(context).getTranslated("view_all"),
              text: AppLocale.of(context).getTranslated("top_celebrities"),
              onTap: () {
                Getx.of(context).toGet(CelerbiresPage());
              },
            ),
            CelebritiesUI(),
            row(
              viewAll: AppLocale.of(context).getTranslated("view_all"),
              text: AppLocale.of(context).getTranslated("top_products"),
              onTap: () async {
                Getx.of(context).toGet(AllViewProducts());
              },
            ),
            ListProductUI(),
            TopBrandUI(),
            TopCategoriesUI(),
            CategoryCard(),
            row(
                viewAll: AppLocale.of(context).getTranslated("view_all"),
                text: AppLocale.of(context).getTranslated("top_products"),
                onTap: () async {
                  Getx.of(context).toGet(AllViewProducts());
                }),
            ListProductUI(),
            TopBrandUI(),
            TopCategoriesUI(),
            CategoryCard(),
          ],
        ),
      ),
    );
  }

  get line =>
      Divider(thickness: 0.5, height: 1, color: Colors.black.withOpacity(0.4));
}
