import 'package:flutter/cupertino.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_grid_celebrities.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class CelebritiesHome {
  static Widget celebritiesFuture(Size size, superReload) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.celebrities().asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return ModelListGridCelebrities.grid(size, snapshot.data.celebrities,
              is6: true);
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
