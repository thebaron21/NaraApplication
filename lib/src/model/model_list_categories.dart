import 'dart:math';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/view/pages/categories/categories_product_view.dart';
import '../logic/config/end_colors.dart';
import '../logic/model/model_categories.dart';
import '../view/widgets/widget_network_image.dart';
import 'dart:math' as math;

class ModelCategoriesList {
  static Widget list(List categories, Size size) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return category(
          context,
          categories[index],
          size: size,
          onTap: () {
            RouterF.of(context)
                .push(() => CategoriesProductView(category: categories[index]));
          },
        );
      },
    );
  }

  static Widget category(con, ModelCategory category,
      {Function onTap, Size size}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/frosted-glass-texture.jpg"),
          ),
          color: Colors.black, //.withOpacity(0.3)
          backgroundBlendMode: BlendMode.color,
        ),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: EndColors
                .colors[math.Random().nextInt(EndColors.colors.length - 1)]
                .withOpacity(0.2),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.2,
                child: Opacity(
                  opacity: 0.5,
                  child: WidgetNetWork(
                    image: category.image,
                  ),
                ),
              ),
              Center(
                child: BorderedText(
                  strokeWidth: 1.5,
                  child: Text(
                    category.name,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget topCategory(Size size, List categories, context) {
    Random _random = Random();
    return categoryTop(
        size, categories[_random.nextInt(categories.length)], context);
  }

  static Widget categoryTop(size, ModelCategory category, context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: size.width,
      height: size.height * 0.43,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            category.image,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 70),
          Center(
            child: BorderedText(
              strokeWidth: 1.5,
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.16,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: size.width * 0.5,
                  child: Text(
                    category.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    onPressed: () {
                      RouterF.of(context).push(
                          () => CategoriesProductView(category: category));
                    },
                    color: kcPrimaryColor,
                    child: Text(
                      AppLocale.of(context).getTranslated("shop_now"),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
