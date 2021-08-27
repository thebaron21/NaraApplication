import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/product_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/core/repoitorites/product_respoitory.dart';
import 'package:myapp3/views/pages/product/product.dart';
import 'package:myapp3/views/widgets/network_widget.dart';
import 'package:provider/provider.dart';

class ListProductUI extends StatefulWidget {
  const ListProductUI({Key key}) : super(key: key);

  @override
  _ListProductUIState createState() => _ListProductUIState();
}

class _ListProductUIState extends State<ListProductUI> {
  @override
  void initState() {
    super.initState();
    productsRxdartBloc.getProducts("3");
  }

  @override
  void dispose() {
    super.dispose();
    productsRxdartBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<ProductModelRespoitory>(
      stream: productsRxdartBloc.subject.stream,
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
            return _buildWidgetProducts(size, snapshot.data.products);
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

  Widget _buildWidgetProducts(Size size, List<ProductModel> products) {
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: ListView.builder(
        shrinkWrap: true,
        // physics: ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return  CardProduct(
            model: products[index],
            onBuy: () {
              Getx.of(context).toGet(ProductPage(
                model: products[index],
              ));
            },
            image: products[index].image,
            price: "${products[index].price} KWD",
            text: "${products[index].name}",
            desc: "${products[index].desc}",
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CardProduct extends StatefulWidget {
  final int id;
  final String price;
  final String text;
  final String desc;
  final Function onBuy;
  final ProductModel model;
  String image;
  CardProduct(
      {Key key,
      this.price,
      this.text,
      this.image,
      this.id,
      this.desc,
      @required this.onBuy,
      this.model})
      : super(key: key);

  @override
  _CardProductState createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  bool isFavorities = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String descr = widget.desc;
    if (widget.desc.length >= 60) descr = widget.desc.substring(0, 60) + " ...";
    return Container(
      margin: EdgeInsets.all(2),
      width: size.width * 0.49,
      height: size.height * 0.43,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.25,
            width: size.width * 0.49,
            child: CustomeNetWork(
              image: widget.image,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.text,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              descr,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.price,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          buyAndFavorite(
            onBuyNow: widget.onBuy,
            onFavorite: () async {
              // await Hive.box(Boxs.FavoritiesBox).clear();
              int index = -1;
              bool isFavorite = false;
              if (Hive.box(Boxs.FavoritiesBox).values.length > 0) {
                for (var i in Hive.box(Boxs.FavoritiesBox).values.toList()) {
                  index++;
                  if ((i as ProductModel).toMap()["id"] ==
                      widget.model.toMap()["id"]) {
                    isFavorite = true;
                  }
                }
              }
              print("isFavorite : $isFavorite , Index : $index");

              if (isFavorite == false) {
                await Hive.box(Boxs.FavoritiesBox).add(widget.model);
              } else {
                Hive.box(Boxs.FavoritiesBox).deleteAt(index);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buyAndFavorite({Function onFavorite, Function onBuyNow}) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: GestureDetector(
            onTap: onBuyNow,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF111111),
              ),
              alignment: Alignment.center,
              child: Text(
                AppLocale.of(context).getTranslated("view"),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: onFavorite,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: ValueListenableBuilder(
                valueListenable: Hive.box(Boxs.FavoritiesBox).listenable(),
                // ignore: missing_return
                builder: (BuildContext context, Box value, Widget child) {
                  bool isFavorite = false;
                  if (value.values.length > 0) {
                    for (var i in value.values.toList()) {
                      if ((i as ProductModel).toMap()["id"] ==
                          widget.model.toMap()["id"]) {
                        isFavorite = true;
                      }
                    }
                  }
                  if (isFavorite == false) {
                    return Icon(Icons.favorite_border);
                  } else {
                    return Icon(Icons.favorite);
                  }
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
