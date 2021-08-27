import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/controller/hive_box.dart';
import 'package:myapp3/core/model/cart_model.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/views/pages/cart/cart_shopping.dart';

import 'network_widget.dart';

Color primaryColor = Color(0xFF448375);
Color kcPrimaryColor = Color(0xFF6B2592);

class ImageProduct extends StatelessWidget {
  final String image;
  const ImageProduct({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: kcPrimaryColor,
        ),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.upload_outlined,
          //     color: Colors.black,
          //     size: 20,
          //   ),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: CustomeNetWork(image: image),
      ),
    );
  }
}

Widget customButton(Size size,
    {IconData icon,
    Color iconColor,
    String txt,
    @required Function onTap,
    bool isAdd = true,
    Color backColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: isAdd == true ? size.width * 0.6 : size.width * 0.4,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: backColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          isAdd == true ? SizedBox(width: 15) : SizedBox(width: 5),
          Text(
            txt,
            style: isAdd == true
                ? TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 0.7
                      ..color = Colors.white,
                  )
                : TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    ),
  );
}

AppBar customAppBar({BuildContext context}) {
  return AppBar(
    elevation: 0.5,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.grey[200],
    actions: [
      IconButton(
        icon: Icon(
          Icons.upload_outlined,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.favorite_outline,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        onPressed: () {
          Getx.of(context).toGet(CartShopping());
        },
      ),
    ],
  );
}

Container customSliderImage(Size size, List<String> images) {
  return Container(
    height: size.height * 0.55,
    width: size.width,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
        ),
      ],
    ),
    child: ListView.builder(
      itemCount: images.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Getx.of(context).toGet(
              ImageProduct(
                image: images[index],
              ),
            );
          },
          child: Container(
            width: size.width,
            height: size.height * 0.55,
            child: CustomeNetWork(image: images[index]),
          ),
        );
      },
    ),
  );
}

customButtonSheet(BuildContext context, Size size, ProductModel data,
    {@required Function onTap, @required Function onTapFavorite}) {
  CartItemModel coverModel = CartItemModel(
    id: data.id.toString(),
    count: 1,
    name: data.name,
    price: int.parse(data.price),
    totalPrice: int.parse(data.price),
    image: data.image,
    desc: data.desc,
  );
  return Container(
    width: size.width,
    height: size.height * 0.06,
    color: Colors.red,
    child: Row(
      children: [
        GestureDetector(
          onTap: onTapFavorite,
          child: Container(
            width: size.width * 0.4,
            height: size.height * 0.07,
            decoration: BoxDecoration(
              color: kcPrimaryColor,
            ),
            child: ValueListenableBuilder(
              valueListenable: Hive.box(Boxs.FavoritiesBox).listenable(),
              // ignore: missing_return
              builder: (BuildContext context, Box value, Widget child) {
                bool isFavorite = false;
                for (var i in value.values.toList()) {
                  if ((i as ProductModel).toMap()["id"] == data.toMap()["id"]) {
                    isFavorite = true;
                  }
                }
                if (isFavorite == false) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 5),
                      Text(
                        "المفضل",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                  // return
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite),
                      SizedBox(width: 5),
                      Text(
                        "المفضل",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: size.width * 0.6,
            height: size.height * 0.07,
            decoration: BoxDecoration(
              color: Color(0xFF111111),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: kcPrimaryColor,
                ),
                SizedBox(width: 15),
                ValueListenableBuilder(
                  valueListenable: Hive.box(Boxs.CartItem).listenable(),
                  // ignore: missing_return
                  builder: (BuildContext context, Box value, Widget child) {
                    var f = value.values
                        .toList()
                        .where((element) => coverModel.id == element.id);

                    if (f.length == 0) {
                      return _te("إضافة إلى السلة");
                    } else {
                      return _te("الذهاب إلى السلة");
                    }
                  },
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

_te(String s) {
  return Text(
    s,
    style: TextStyle(
      fontSize: 20,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7
        ..color = Colors.white,
    ),
  );
}

void msgBox(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return AlertDialog(
        title: Text("Title2"),
        content: Text("Container"),
        actions: [
          Row(
            children: [
              btn(
                size,
                "YES",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 10,
              ),
              btn(
                size,
                "Checkout",
                onTap: () {},
              ),
            ],
          )
        ],
      );
    },
  );
}

btn(size, String txt, {Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: size.width * 0.3,
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: kcPrimaryColor,
      ),
      alignment: Alignment.center,
      child: Center(
        child: Text(
          "$txt",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
