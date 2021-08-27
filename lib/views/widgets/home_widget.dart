import 'package:flutter/material.dart';
import 'package:myapp3/core/controller/control.dart';

class ImageProduct extends StatelessWidget {
  final String image;
  const ImageProduct({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              image,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

customButton(Size size,
    {IconData icon,
    Color iconColor,
    String txt,
    bool isAdd = true,
    Color backColor}) {
  return Container(
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
  );
}

customAppBar() {
  return AppBar(
    elevation: 0.5,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    actions: [
      IconButton(
        icon: Icon(
          Icons.upload_rounded,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.favorite_border_outlined,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    ],
  );
}

customSliderImage(Size size, List<String> images) {
  return Container(
    height: size.height * 0.55,
    width: size.width,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 4,
        ),
      ],
      color: Colors.amber,
    ),
    child: ListView.builder(
      itemCount: images.length - 1,
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
            margin: EdgeInsets.all(3),
            width: size.width,
            height: size.height * 0.55,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}
