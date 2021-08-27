import 'package:flutter/material.dart';
import 'package:myapp3/core/model/celebrity_model.dart';
import 'package:myapp3/views/widgets/row_product.dart';

class ProductCelebritiesPage extends StatefulWidget {
  final Celebrity celebrity;
  const ProductCelebritiesPage({Key key, this.celebrity}) : super(key: key);

  @override
  _ProductCelebritiesPageState createState() => _ProductCelebritiesPageState();
}

class _ProductCelebritiesPageState extends State<ProductCelebritiesPage> {
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(
          context: context,
          title: widget.celebrity.name,
          onTap: () {
            isSearch == false
                ? setState(() => isSearch = true)
                : setState(() => isSearch = false);
            print(isSearch);
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isSearch == true ? _search(size, searchController) : Container(),
            _imageHero(size)
          ],
        ),
      ),
    );
  }

  _search(Size size, TextEditingController controller) {
    return Center(
      child: Container(
        width: size.width * .95,
        height: 39,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _circle(
              size,
              true,
              Icon(Icons.close, size: 19, color: Colors.white),
              onTap: () {
                controller.clear();
                setState(() => isSearch = false);
              },
            ),
            Flexible(
              child: Container(
                height: 30,
                child: Center(
                  child: TextField(
                    scrollPhysics: ScrollPhysics(),
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type Name Celebrities ...",
                      hintStyle: TextStyle(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..color = Colors.black
                          ..strokeWidth = 0.7,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _circle(
              size,
              false,
              Icon(Icons.search, size: 19, color: Colors.black),
              onTap: () {
                print("Search ...");
              },
            ),
          ],
        ),
      ),
    );
  }

  _circle(Size size, bool isColor, Icon icon, {Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isColor == true
              ? Colors.blueGrey.withOpacity(0.6)
              : Colors.white.withOpacity(0),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }

  _imageHero(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.celebrity.image),
        ),
      ),
      child: Text(widget.celebrity.image),
    );
  }
}
