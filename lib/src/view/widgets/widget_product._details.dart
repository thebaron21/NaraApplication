import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/function/home_function.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/model/cart_model.dart';
import 'package:myapp3/src/logic/model/product_model.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_grid_product.dart';
import 'package:myapp3/src/view/app_nara.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';
import 'package:myapp3/src/view/widgets/widget_network_image.dart';

import 'widget_appbar.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel model;
  const ProductDetailsView({Key key, this.model}) : super(key: key);

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  Color primaryColor = Color(0xFF448375);
  Color kcPrimaryColor = Color(0xFF6B2592);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: widget.model.name,
        isCart: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSliderImage(size, [widget.model.image]),
            customDetailsProduct(
              size,
              nameBrand: widget.model.name,
              price: widget.model.price,
              desc: widget.model.desc,
              name: widget.model.name,
            ),
            //--------------------------------------
            Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.3),
            ),
            customYouMayAlsoLike(size),
            //--------------------------------------
            SizedBox(
              width: size.width,
              height: size.height * 0.07,
            )
          ],
        ),
      ),
      bottomSheet: customButtonSheet(
        context,
        size,
        widget.model,
        onTap: () async {
          var data = widget.model;
          CartItemModel coverModel = CartItemModel(
            id: data.id.toString(),
            count: 1,
            name: data.name,
            price: int.parse(data.price),
            totalPrice: int.parse(data.price),
            image: data.image,
            desc: data.desc,
          );
          var cartBox = Hive.box(EndBoxs.CartItem);
          var f = cartBox.values
              .toList()
              .where((element) => coverModel.id == element.id);
          if (f.length == 0) {
            await cartBox.add(coverModel);
          } else {
            RouterF.of(context).push(() => AppNara(init: Nav.MYBAD));
          }
        },
        onTapFavorite: () async {
          int index = -1;
          var f = Hive.box(EndBoxs.FavoritiesBox).values.contains(widget.model);
          if (f == false) {
            await Hive.box(EndBoxs.FavoritiesBox).add(widget.model);
          } else {
            for (var i in Hive.box(EndBoxs.FavoritiesBox).values.toList()) {
              index++;
              if ((i as ProductModel).toMap()["id"] ==
                  widget.model.toMap()["id"]) {
                Hive.box(EndBoxs.FavoritiesBox).deleteAt(index);
              }
            }
          }
        },
      ),
    );
  }

  customYouMayAlsoLike(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "مزيد من المنتجات",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            height: 1,
            width: size.width * 0.6,
            color: Colors.black,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
              height: size.height * 0.5,
              child: StreamBuilder(
                stream: ResCategoryProductCelebrities.products().asStream(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ModelListGridProduct.list(
                        size, snapshot.data.products, true);
                  } else if (snapshot.hasError) {
                    return WidgetFuture.error(context, () => setState(() {}));
                  } else {
                    return WidgetFuture.loading();
                  }
                },
              )),
          SizedBox(
            width: size.width,
            height: size.height * 0.01,
          )
        ],
      ),
    );
  }

  Icon iconStar = Icon(Icons.star_border_purple500_sharp);
  Padding customDetailsProduct(Size size,
      {String nameBrand, String price, String desc, String name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          SizedBox(
            height: 10,
          ),
          _customNameBrand(nameBrand, size),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              iconStar,
              iconStar,
              iconStar,
              iconStar,
              iconStar,
              SizedBox(width: 10),
              Text(
                "تقييم المنتج",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Text(
              "$price ",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Divider(
            thickness: 1,
            color: Colors.black.withOpacity(0.3),
          ),
          Text(
            "الوصف",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "$desc",
          )
        ],
      ),
    );
  }

  Container customSliderImage(Size size, List<String> images) {
    return Container(
      height: size.height * 0.55,
      width: size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              width: size.width,
              height: size.height * 0.55,
              child: WidgetNetWork(image: images[index]),
            ),
          );
        },
      ),
    );
  }

  Container _customNameBrand(String nameBrand, Size size) {
    return Container(
      width: size.width * 0.35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                "الماركة",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              height: 35,
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  nameBrand,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  customButtonSheet(BuildContext context, Size size, ProductModel data,
      {@required Function onTap, @required Function onTapFavorite}) {
    CartItemModel coverModel = CartItemModel(
      id: data.id.toString(),
      count: 1,
      name: data.name,
      price: int.parse(data.price),
      totalPrice: int.parse(data.price),
      image: data.image,
      desc: data.desc,
    );
    return Container(
      width: size.width,
      height: size.height * 0.06,
      color: Colors.red,
      child: Row(
        children: [
          GestureDetector(
            onTap: onTapFavorite,
            child: Container(
              width: size.width * 0.4,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                color: kcPrimaryColor,
              ),
              child: ValueListenableBuilder(
                valueListenable: Hive.box(EndBoxs.FavoritiesBox).listenable(),
                // ignore: missing_return
                builder: (BuildContext context, Box value, Widget child) {
                  bool isFavorite = false;
                  for (var i in value.values.toList()) {
                    if ((i as ProductModel).toMap()["id"] ==
                        data.toMap()["id"]) {
                      isFavorite = true;
                    }
                  }
                  if (isFavorite == false) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(width: 5),
                        Text(
                          "المفضل",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                    // return
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite),
                        SizedBox(width: 5),
                        Text(
                          "المفضل",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.07,
              decoration: BoxDecoration(
                color: Color(0xFF111111),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: kcPrimaryColor,
                  ),
                  SizedBox(width: 15),
                  ValueListenableBuilder(
                    valueListenable: Hive.box(EndBoxs.CartItem).listenable(),
                    // ignore: missing_return
                    builder: (BuildContext context, Box value, Widget child) {
                      var f = value.values
                          .toList()
                          .where((element) => coverModel.id == element.id);

                      if (f.length == 0) {
                        return _te("إضافة إلى السلة");
                      } else {
                        return _te("الذهاب إلى السلة");
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _te(String s) {
    return Text(
      s,
      style: TextStyle(
        fontSize: 20,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.7
          ..color = Colors.white,
      ),
    );
  }
}
