import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/bloc/rxdartBloc/product_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/categories_model.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/core/repoitorites/product_respoitory.dart';
import 'package:myapp3/views/pages/home/ui/product_ui.dart';
import 'package:myapp3/views/pages/product/product.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';

class CategoryID extends StatefulWidget {
  final CategoryModel category;
  const CategoryID({Key key, this.category}) : super(key: key);

  @override
  _CategoryIDState createState() => _CategoryIDState();
}

class _CategoryIDState extends State<CategoryID> {
  @override
  void initState() {
    super.initState();
    productsRxdartBloc..getProducts(widget.category.id.toString());
  }
  

  @override
  void dispose() {
    super.dispose();
    productsRxdartBloc.close();
  }

  bool _value = false;
  int val = -1;
  get _sortFillter => (size) {
        return Container(
          width: size.width * 0.8,
          height: size.height * 0.25,
          decoration: BoxDecoration(
            border: Border.all(color: kcPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  color: kcPrimaryColor,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "رتب حسب",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              // _radio(1, "اخر"),
              // _radio(2,  "السعر : الأقل أولاً"),
              // _radio(3,  "السعر : الأكثر أولاً"),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("title"),
                    Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() => val = value);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("title"),
                    Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() => val = value);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("title"),
                    Radio(
                      value: 3,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() => val = value);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        );
      };

  bool isDialog = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: buildCustome(context),
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.category.name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(
                  image: NetworkImage(
                    widget.category.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.07,
              decoration: BoxDecoration(color: Colors.grey[200], boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, -3),
                )
              ]),
              // child: Row(
              //   children: [
              //     Expanded(
              //       child: FlatButton.icon(
              //         label: Text(
              //          AppLocale.of(context).getTranslated("filtter"),
              //         ),
              //         icon: Icon(Icons.filter_list),
              //         onPressed: () {
              //           setState(() => isDialog = true);
              //         },
              //       ),
              //     ),
              //     Expanded(
              //       child: FlatButton.icon(
              //           label: Text(
              //             AppLocale.of(context).getTranslated("sort"),
              //           ),
              //           icon: Icon(Icons.sort),
              //           onPressed: () {}),
              //     ),
              //   ],
              // ),
            ),
            StreamBuilder<ProductModelRespoitory>(
              stream: productsRxdartBloc.subject.stream,
              // ignore: missing_return
              builder:
                  (context, AsyncSnapshot<ProductModelRespoitory> snapshot) {
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
            )
          ],
        ),
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

  

  get line =>
      Divider(thickness: 0.5, height: 1, color: Colors.black.withOpacity(0.4));
}
