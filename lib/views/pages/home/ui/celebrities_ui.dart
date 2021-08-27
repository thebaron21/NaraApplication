import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/bloc/rxdartBloc/celebrities_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/categories_model.dart';
import 'package:myapp3/core/model/celebrity_model.dart';
import 'package:myapp3/core/repoitorites/celebrity_repoitory.dart';
import 'package:myapp3/views/pages/categories/categories_product.dart';
import 'package:myapp3/views/pages/categories/category_id.dart';
import 'package:myapp3/views/pages/product/product_celebrities.dart';
import 'package:myapp3/views/widgets/network_widget.dart';

class CelebritiesUI extends StatefulWidget {
  const CelebritiesUI({Key key}) : super(key: key);

  @override
  _CelebritiesUIState createState() => _CelebritiesUIState();
}

class _CelebritiesUIState extends State<CelebritiesUI> {
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    celebritiesRxdartBloc..getCelebrities();
  }

  @override
  void dispose() {
    super.dispose();
    celebritiesRxdartBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<CelebrityRepoitory>(
      stream: celebritiesRxdartBloc.subject.stream,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<CelebrityRepoitory> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null &&
              snapshot.data.celebrity.length > 0) {
            return _buildWidgetError(size, snapshot.data.error);
          } else if (snapshot.data.exception != null &&
              snapshot.data.error == null &&
              snapshot.data.celebrity.length > 0) {
            return _buildWidgetException(size, snapshot.data.exception);
          } else {
            return _buildWidgetCelebrities(size, snapshot.data.celebrity);
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

  Widget _buildWidgetCelebrities(Size size, List<Celebrity> celebrity) {
    int len = celebrity.length;
    if (celebrity.length >= 6) len = 6;
    return Container(
      // height: size.height * 0.6,
      width: size.width,
      child: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: len,
        itemBuilder: (BuildContext context, int index) {
          return celebrityModel(size, celebrity[index], index);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }

  Widget celebrityModel(Size size, Celebrity data, index) {
    return InkWell(
      onTap: () {
        // Getx.of( context).toGet(ProductCelebritiesPage(celebrity: data));
        Getx.of(context).toGet(
          BlocProvider<CategoriesBloc>(
            create: (_) => CategoriesBloc(),
            lazy: false,
            child: CategoriesProducts(
              name: data.name,
              index: data.id.toString(),
            ),
          ),
        );
      },
      child: Container(
        width: size.width * 0.35,
        margin: EdgeInsets.all(5),
        // height: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Flexible(
                child: CustomeNetWork(
              image: data.image,
            )),
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
