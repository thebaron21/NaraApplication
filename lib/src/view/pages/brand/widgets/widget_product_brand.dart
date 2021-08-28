import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_grid_product.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class WidgetProductBrand {
  static Widget brandsFuture(Size size, superReload, String name) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.getProductBrand(idBrand: name)
          .asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ModelListGridProduct.grid(size, snapshot.data.products);
        } else if (snapshot.hasError) {
          return WidgetFuture.error(context, superReload);
        } else {
          return WidgetFuture.loading();
        }
      },
    );
  }

  static Widget space(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.05,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
      ),
    );
  }

  static Widget hero(image, size) {
    return Container(
      width: size.width,
      height: size.height * 0.25,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
      ),
    );
  }
}
