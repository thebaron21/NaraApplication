import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../logic/config/LocaleLang.dart';
import '../../logic/config/end_boxs.dart';
import '../../logic/model/product_model.dart';

import 'widget_network_image.dart';

class WidgetProduct extends StatefulWidget {
  final Function onBuy;
  final ProductModel model;
  WidgetProduct({Key key, @required this.onBuy, this.model}) : super(key: key);

  @override
  _WidgetProductState createState() => _WidgetProductState();
}

class _WidgetProductState extends State<WidgetProduct> {
  bool isFavorities = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String desc = widget.model.desc;
    if (widget.model.desc.length >= 60)
      desc = widget.model.desc.substring(0, 60) + " ...";
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
            height: size.height * 0.2,
            width: size.width * 0.49,
            child: WidgetNetWork(
              image: widget.model.image,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.model.name,
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
              desc,
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
              widget.model.price,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          buyAndFavorite(
            onBuyNow: widget.onBuy,
            onFavorite: () async {
              // await Hive.box(EndBoxs.FavoritiesBox).clear();
              int index = -1;
              bool isFavorite = false;
              if (Hive.box(EndBoxs.FavoritiesBox).values.length > 0) {
                for (var i in Hive.box(EndBoxs.FavoritiesBox).values.toList()) {
                  index++;
                  if ((i as ProductModel).toMap()["id"] ==
                      widget.model.toMap()["id"]) {
                    isFavorite = true;
                  }
                }
              }
              print("isFavorite : $isFavorite , Index : $index");

              if (isFavorite == false) {
                await Hive.box(EndBoxs.FavoritiesBox).add(widget.model);
              } else {
                Hive.box(EndBoxs.FavoritiesBox).deleteAt(index);
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
                valueListenable: Hive.box(EndBoxs.FavoritiesBox).listenable(),
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
