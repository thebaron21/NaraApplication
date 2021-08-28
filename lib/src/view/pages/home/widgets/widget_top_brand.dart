import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_brand.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class TopBrandHome {
  static Widget brands(Size size, superReload) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.brands().asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ModelListBarnd.twoBarnd(snapshot.data.brands, size);
        } else if (snapshot.hasError) {
          return WidgetFuture.error(context, superReload);
        } else {
          return WidgetFuture.loading();
        }
      },
    );
  }
}
