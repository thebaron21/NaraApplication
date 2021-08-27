import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'dart:math' as math;
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/bloc/rxdartBloc/categories_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/categories_model.dart';
import 'package:myapp3/core/repoitorites/categories_repoitory.dart';
import 'package:myapp3/views/pages/auth_screen/profile_page.dart';
import 'package:myapp3/views/pages/favorities/favorities_page.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';
import 'package:myapp3/views/widgets/row_product.dart';
import '../../widgets/network_widget.dart';
import 'categories_product.dart';
import 'package:bordered_text/bordered_text.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> images = [];
  List<String> txt = [];
  List<Color> colors = [
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.blueGrey,
    Colors.lightGreen,
    Colors.teal,
    Colors.pink,
    Colors.red,
    Colors.amber,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.blueGrey,
    Colors.lightGreen,
    Colors.teal,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    allCategoriesRxdarBloc.getAllCategories();
  }

  @override
  void dispose() {
    super.dispose();
    allCategoriesRxdarBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: buildCustome(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("categories"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<CategoriesRespoitory>(
        stream: allCategoriesRxdarBloc.subjectAllCategories.stream,
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
              return _buildWidgetCategories(size, snapshot.data.categories);
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

  Widget customCardCategory(con, CategoryModel category,
      {Function onTap, int index, Size size, CategoriesBloc bloc}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/frosted-glass-texture.jpg"),
          ),
          color: Colors.black, //.withOpacity(0.3)
          backgroundBlendMode: BlendMode.color,
        ),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: colors[math.Random().nextInt(colors.length - 1)]
                .withOpacity(0.2),
          ),
          child: Stack(
            children: [
              SizedBox(
                  width: size.width,
                  height: size.height * 0.2,
                  child: Opacity(
                    opacity: 0.5,
                    child: CustomeNetWork(
                      image: category.image,
                    ),
                  )),
              Center(
                child: BorderedText(
            strokeWidth: 1.5,
           child: Text(
                  category.name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w900,
                      color:Colors.white,
                ),
              ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetCategories(Size size, List<CategoryModel> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return customCardCategory(context, categories[index],
            size: size,
            index: categories[index].id,
            bloc: context.read<CategoriesBloc>(), onTap: () {
          Getx.of(context).toGet(BlocProvider<CategoriesBloc>(
            create: (_) => CategoriesBloc(),
            lazy: false,
            child: CategoriesProducts(
              name: categories[index].name,
              index: categories[index].id.toString(),
            ),
          ));
        });
      },
    );
  }

  get line =>
      Divider(thickness: 0.5, height: 1, color: Colors.black.withOpacity(0.4));
}
