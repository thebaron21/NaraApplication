import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_grid_celebrities.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class WidgetCelebritiesView {
  static Widget celebritiesFuture(Size size, superReload, String name) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.celebrities2(name: name).asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ModelListGridCelebrities.grid(size, snapshot.data.celebrities);
        } else if (snapshot.hasError) {
          return WidgetFuture.error(context, superReload);
        } else {
          return WidgetFuture.loading();
        }
      },
    );
  }
}
