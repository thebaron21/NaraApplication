import 'dart:math';
import 'package:flutter/material.dart';
import '../logic/model/model_brand.dart';
import '../view/widgets/widget_network_image.dart';

class ModelListBarnd {
  static Widget twoBarnd(List brands, Size size) {
    Random _random = Random();
    return Container(
      height: size.height * 0.23,
      width: double.infinity,
      child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              barand(
                size: size,
                image: brands[_random.nextInt(brands.length)].image,
                onTap: () {},
              ),
              barand(
                size: size,
                image: brands[_random.nextInt(brands.length)].image,
                onTap: () {},
              )
            ]),
      ),
    );
  }

  static Widget barand({Size size, Function onTap, String image}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        width: size.width * 0.43,
        height: size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: WidgetNetWork(
          image: image,
        ),
      ),
    );
  }

  static Widget brandsList(List brands, Size size) {
    return ListView.builder(
      itemCount: brands.length,
      itemBuilder: (BuildContext context, int index) {
        return cardTile(brands[index], size, context);
      },
    );
  }

  static Widget cardTile(ModelBrand brand, Size size, context) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.07,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                width: size.width * 0.1,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(brand.image)),
                ),
              ),
              SizedBox(width: 20),
              Container(
                color: Colors.grey,
                height: size.height * 0.05,
                width: 1,
              ),
              SizedBox(width: 20),
              Text(
                brand.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
