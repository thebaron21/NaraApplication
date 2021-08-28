import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/view/pages/categories/categories_product_view.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';
import 'package:myapp3/src/view/widgets/widget_network_image.dart';
import 'package:page_indicator/page_indicator.dart';

class SliderHome {
  static Widget sliderFuture(Size size, controller, superReload) {
    return StreamBuilder(
      stream: ResCategoryProductCelebrities.categoriesSlider().asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _slider(size, controller, snapshot.data.categories);
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

  static Widget _slider(Size size, controller, categories) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: PageIndicatorContainer(
        length: categories.length,
        align: IndicatorAlign.bottom,
        indicatorSpace: 5.0,
        padding: const EdgeInsets.all(10),
        indicatorColor: Colors.white,
        indicatorSelectorColor: kcPrimaryColor,
        shape: IndicatorShape.circle(size: 10),
        child: PageView.builder(
          controller: controller,
          itemCount: categories.length,
          itemBuilder: (context, int index) {
            return InkWell(
              onTap: () {
                RouterF.of(context).push(
                    () => CategoriesProductView(category: categories[index]));
              },
              child: Container(
                width: size.width,
                height: size.height * 0.34,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: WidgetNetWork(image: categories[index].image),
              ),
            );
          },
        ),
      ),
    );
  }
}
