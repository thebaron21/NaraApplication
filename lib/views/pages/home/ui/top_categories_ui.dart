import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/brand_rxdart_bloc.dart';
import 'package:myapp3/core/bloc/rxdartBloc/categories_rxdart_bloc.dart';
import 'package:myapp3/core/model/brand_model.dart';
import 'package:myapp3/core/model/categories_model.dart';
import 'package:myapp3/core/repoitorites/brand_repository.dart';
import 'package:myapp3/core/repoitorites/categories_repoitory.dart';
import 'package:myapp3/views/widgets/network_widget.dart';

class TopCategoriesUI extends StatefulWidget {
  const TopCategoriesUI({Key key}) : super(key: key);

  @override
  _TopCategoriesUIState createState() => _TopCategoriesUIState();
}

class _TopCategoriesUIState extends State<TopCategoriesUI> {
  Random _random = Random();
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    brandRxdartBloc.getBrands();
  }

  @override
  void dispose() {
    super.dispose();
    brandRxdartBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<BrandRepository>(
      stream: brandRxdartBloc.brands.stream,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<BrandRepository> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.brands.length <= 0) {
            return _buildWidgetError(size, snapshot.data.error);
          } else {
            return _buildTopBrands(size, snapshot.data.brands);
          }
        } else if (snapshot.hasError) {
          return _buildError(size, snapshot.error);
        } else {
          return _buildWidgetLoading(size);
        }
      },
    );
  }

  Widget _buildWidgetError(Size size, error) {
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

  Widget _buildTopBrands(Size size, List<BrandModel> categories) {
    return Container(
      height: size.height * 0.23,
      width: double.infinity,
      child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _card(
                size: size,
                image: categories[_random.nextInt(categories.length)].image,
                onTap: () {},
              ),
              _card(
                size: size,
                image: categories[_random.nextInt(categories.length)].image,
                onTap: () {},
              )
            ]),
      ),
    );
  }

  Widget _card({Size size, Function onTap, String image}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        width: size.width * 0.43,
        height: size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: CustomeNetWork(
          image: image,
        ),
      ),
    );
  }
}
