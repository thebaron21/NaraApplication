import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_categories.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class TopCategoriesHome {
  static Widget categories(Size size, superReload) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.categories().asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ModelCategoriesList.topCategory(
              size, snapshot.data.categories, context);
        } else if (snapshot.hasError) {
          return WidgetFuture.error(context, superReload);
        } else {
          return WidgetFuture.loading();
        }
      },
    );
  }
}
