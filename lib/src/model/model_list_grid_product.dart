import 'package:flutter/cupertino.dart';
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
            onBuy: () {},
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 5,
        ),
      ),
    );
    ;
  }

  static Widget list(Size size, List products, bool ishorizontal) {
    return Container(
      width: size.width,
      height: size.height * 0.5,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: ishorizontal == true ? Axis.horizontal : Axis.vertical,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return WidgetProduct(
            model: products[index],
            onBuy: () {},
          );
        },
      ),
    );
    ;
  }
}
