
import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/view/widgets/widget_network_image.dart';

class WidgetCart extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String count;
  final Function increment;
  final Function decrement;

  const WidgetCart(
      {Key key,
      @required this.image,
      @required this.name,
      @required this.price,
      @required this.count,
      @required this.increment,
      @required this.decrement})
      : super(key: key);
  @override
  _WidgetCartState createState() => _WidgetCartState();
}

class _WidgetCartState extends State<WidgetCart> {
  @override
  Widget build(BuildContext context) {
    // Size sizeSelected = MediaQuery.of(context).size;
    bool openShow = false;
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Back Widget
            Center(
              child: Container(
                margin: EdgeInsets.all(5),
                height:
                    openShow == false ? size.height * 0.15 : size.height * 0.2,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),
            // Body or Row Widget it's Content anythings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildContainerImage(widget.image),
                SizedBox(
                  width: size.width * 0.08,
                ),
                Expanded(
                  child: buildRichText(),
                ),
                // SizedBox(
                //   width: size.width * 0.28,
                // ),
                buildContainer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildContainerImage(String image) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: kcPrimaryColor.withOpacity(0.2),
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: WidgetNetWork(
        image: image,
      ),
    );
  }

  RichText buildRichText() {
    return RichText(
      maxLines: 3,
      text: TextSpan(children: [
        TextSpan(
          text: widget.name + "\n",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        TextSpan(
          text: "${AppLocale.of(context).getTranslated("price")} : " +
              widget.price,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
        ),
      ]),
    );
  }

  Container buildContainer() {
    return Container(
      width: 40,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
              child: Icon(Icons.add, color: kcPrimaryColor),
              onTap: widget.increment),
          Text("${widget.count}"),
          InkWell(
            child: Icon(Icons.remove, color: kcPrimaryColor),
            onTap: widget.decrement,
          ),
        ],
      ),
    );
  }
}