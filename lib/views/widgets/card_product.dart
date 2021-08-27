import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/core/controller/hive_box.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'network_widget.dart';

class CardProduct extends StatefulWidget {
  final int id;
  final String price;
  final String text;
  final String desc;
  final String image;
  final Function onTap;
  final ProductModel model;
  CardProduct(
      {Key key,
      this.price,
      this.text,
      this.image,
      this.id,
      this.desc,
      @required this.onTap,
      this.model})
      : super(key: key);

  @override
  _CardProductState createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String description;
    if (widget.desc.length >= 60)
      description = widget.desc.substring(0, 60) + " ...";
    else
      description = widget.desc;
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
          Expanded(
            flex: 15,
            child: CustomeNetWork(
              image: widget.image,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              description,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(flex: 2, child: Container()),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.price,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          buyAndFavorite(
            onBuyNow: widget.onTap,
            value: widget.model,
          ),
        ],
      ),
    );
  }

  Widget buyAndFavorite({value, Function onBuyNow}) {
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                ),
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
          flex: 1,
          child: GestureDetector(
            onTap: () async {
              var isV = await Hive.box( Boxs.FavoritiesBox ).add(value);
              print(isV);
            },
            child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(4),
                  ),
                  color: Colors.grey[300],
                ),
                child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box( Boxs.FavoritiesBox ).listenable(),
                  // ignore: missing_return
                  builder: (BuildContext context, Box value, Widget child) {
                    bool isFov = value.values.contains(value);
                    return isFov == false
                        ? Icon(Icons.favorite_border, color: Color(0xFF333333))
                        : Icon(Icons.favorite, color: Color(0xFF333333));
                  },
                )),
          ),
        )
      ],
    );
  }
}
