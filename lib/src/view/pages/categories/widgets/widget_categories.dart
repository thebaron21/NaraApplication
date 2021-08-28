import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_categories.dart';
import 'package:myapp3/src/model/model_list_grid_product.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class WidgetCategoryView {
  static Widget categories(Size size, superReload, name) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.categories(name: name).asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ModelCategoriesList.list(snapshot.data.categories, size);
        } else if (snapshot.hasError) {
          return WidgetFuture.error(context, superReload);
        } else {
          return WidgetFuture.loading();
        }
      },
    );
  }

  static Widget producCategory(id, superReload, size, name) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.products(name: name, categoryId: id)
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
}
