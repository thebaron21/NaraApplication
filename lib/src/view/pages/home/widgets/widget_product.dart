import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_grid_product.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class ProductHome {
  static Widget productsFuture(Size size, superReload) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.products().asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ModelListGridProduct.list(size, snapshot.data.products, true);
        } else if (snapshot.hasError) {
          return WidgetFuture.error(context, superReload);
        } else {
          return Container(
      width: size.width,
      height: size.height * 0.34,
            child: WidgetFuture.loading(),
          );
        }
      },
    );
  }
}
