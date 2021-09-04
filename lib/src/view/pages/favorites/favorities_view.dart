import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/model/product_model.dart';
import 'package:myapp3/src/view/widgets/widget_network_image.dart';
import 'package:myapp3/src/view/widgets/widget_product._details.dart';

class FavoritiesView extends StatefulWidget {
  const FavoritiesView({Key key}) : super(key: key);

  @override
  _FavoritiesViewState createState() => _FavoritiesViewState();
}

class _FavoritiesViewState extends State<FavoritiesView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: buildCustome(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("favorities"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      // ignore: deprecated_member_use
      body: WatchBoxBuilder(
        box: Hive.box(EndBoxs.FavoritiesBox),
        builder: (BuildContext context, Box box) {
          var data = (box.values.toList());
          print(data);
          // return Text("dflj");
          return _buildGridView(data, size);
        },
      ),
    );
  }

  _buildGridView(values, Size size) {
    if (values.length == 0) {
      return Center(
          child:
              Text(AppLocale.of(context).getTranslated("favoritie_is_empty")));
    } else {
      return GridView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel model = values[index];
          return _cardProduct(model, size, index);
          // return Text(model.name);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 5.5,
          crossAxisSpacing: 2 / 8,
          crossAxisCount: 2,
          mainAxisSpacing: 2 / 4,
        ),
      );
    }
  }

  _cardProduct(ProductModel model, Size size, int index) {
    String descf = model.desc;
    if (model.desc.length >= 20) descf = model.desc.substring(0, 20) + " ...";
    return Container(
      // height: size.height * 0.2,
      margin: EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        border: Border.all(
          width: 0.5,
          color: Colors.black.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                width: size.width * 0.6,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10, color: Colors.grey.withOpacity(0.2))
                  ],
                ),
                child: WidgetNetWork(
                  image: model.image,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  await Hive.box(EndBoxs.FavoritiesBox).deleteAt(index);
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(model.name),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              descf,
              textDirection: TextDirection.rtl,
            ),
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                RouterF.of(context).push( () => ProductDetailsView(model: model) );
              },
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: Color(0xFF333333),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    AppLocale.of(context).getTranslated("view"),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  get line =>
      Divider(thickness: 0.5, height: 1, color: Colors.black.withOpacity(0.4));
}
