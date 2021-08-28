import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/model/model_categories.dart';
import 'package:myapp3/src/logic/model/model_celebrities.dart';
import 'package:myapp3/src/view/pages/categories/categories_product_view.dart';
import 'package:myapp3/src/view/widgets/widget_network_image.dart';

class ModelListGridCelebrities {
  static Widget grid(Size size, List celebrities, {is6 = false}) {
    int len = celebrities.length;
    if (celebrities.length >= 6) len = 6;

    return Container(
      // height: size.height * 0.6,
      width: size.width,
      child: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: is6 == true ? len : celebrities.length,
        itemBuilder: (BuildContext context, int index) {
          return _celebrity(size, celebrities[index], context);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }

  static Widget _celebrity(Size size, ModelCelebrity data, context) {
    return InkWell(
      onTap: () {
        RouterF.of(context).push(
          () => CategoriesProductView(
            category:
                ModelCategory(id: data.id, image: data.image, name: data.name),
          ),
        );
      },
      child: Container(
        width: size.width * 0.35,
        margin: EdgeInsets.all(5),
        height: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Expanded(
              child: WidgetNetWork(
                image: data.image,
              ),
            ),
            Text(
              data.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
