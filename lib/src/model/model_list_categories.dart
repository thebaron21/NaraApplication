import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../logic/config/end_colors.dart';
import '../logic/model/model_categories.dart';
import '../view/widgets/widget_network_image.dart';
import 'dart:math' as math;

class ModelCategoriesList {
  static Widget list(List categories, Size size) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return category(context, categories[index], size: size, onTap: () {});
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
}
