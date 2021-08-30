import 'package:flutter/cupertino.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/view/widgets/widget_product._details.dart';
import 'package:myapp3/src/view/widgets/widget_product.dart';

class ModelListGridProduct {
  static Widget grid(Size size, List products) {
    return Container(
      // height: size.height * 0.6,
      width: size.width,
      child: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return WidgetProduct(
            model: products[index],
            onBuy: () {
              RouterF.of(context).push( () => ProductDetailsView(model: products[index],) );
            },
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 5.5,
          mainAxisSpacing: 5,
        ),
      ),
    );
    ;
  }

  static Widget list(Size size, List products, bool ishorizontal) {
    int len = 0;
    if (products.length > 30)
      len = 30;
    else
      len = products.length;
    return Container(
      width: size.width,
      height: size.height * 0.5,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: ishorizontal == true ? Axis.horizontal : Axis.vertical,
        itemCount: len,
        itemBuilder: (BuildContext context, int index) {
          return WidgetProduct(
            model: products[index],
            onBuy: () {
              RouterF.of(context).push( () => ProductDetailsView(model: products[index],) );
            },
          );
        },
      ),
    );
    ;
  }
}
