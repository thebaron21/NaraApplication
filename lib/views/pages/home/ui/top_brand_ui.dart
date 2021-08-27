import 'dart:math';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/categories_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/categories_model.dart';
import 'package:myapp3/core/repoitorites/categories_repoitory.dart';
import 'package:myapp3/views/pages/categories/category_id.dart';
import 'package:myapp3/views/widgets/network_widget.dart';

class TopBrandUI extends StatefulWidget {
  const TopBrandUI({Key key}) : super(key: key);

  @override
  _TopBrandUIState createState() => _TopBrandUIState();
}

class _TopBrandUIState extends State<TopBrandUI> {
  Random _random = Random();
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    categoriesRxdartBloc.getCategories("${_random.nextInt(5)}");
  }

  @override
  void dispose() {
    super.dispose();
    categoriesRxdartBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<CategoriesRespoitory>(
      stream: categoriesRxdartBloc.subject.stream,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<CategoriesRespoitory> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null &&
              snapshot.data.categories.length >= 0) {
            return _buildWidgetError(size, snapshot.data.error);
          } else if (snapshot.data.exception != null &&
              snapshot.data.error == null &&
              snapshot.data.categories.length >= 0) {
            return _buildWidgetException(size, snapshot.data.exception);
          } else {
            return _buildWidgetBrand(size, snapshot.data.categories);
          }
        } else if (snapshot.hasError) {
          return _buildError(size, snapshot.error);
        } else {
          return _buildWidgetLoading(size);
        }
      },
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

  Widget _buildWidgetBrand(Size size, List<CategoryModel> categories) {
    return _brandCard(size, categories[_random.nextInt(categories.length)]);
  }

  _brandCard(size, CategoryModel category) {
    return Container(
      padding: EdgeInsets.all(8),
      width: size.width,
      height: size.height * 0.43,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            category.image,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 70),
          Center(
            child: BorderedText(
              strokeWidth: 1.5,
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.16,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: size.width * 0.5,
                  child: Text(
                    category.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    onPressed: () {
                      Getx.of(context).toGet(CategoryID(category: category));
                    },
                    color: kcPrimaryColor,
                    child: Text(
                      AppLocale.of(context).getTranslated("shop_now"),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
