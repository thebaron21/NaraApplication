import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/controller/favorites_product.dart';
import 'package:myapp3/core/controller/hive_box.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/views/pages/product/product.dart';
import 'package:myapp3/views/widgets/drawer_app.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class FavoritiesPage extends StatefulWidget {
  const FavoritiesPage({Key key}) : super(key: key);

  @override
  _FavoritiesPageState createState() => _FavoritiesPageState();
}

class _FavoritiesPageState extends State<FavoritiesPage> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: buildCustome(context),
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
        body: WatchBoxBuilder(
          box: Hive.box( Boxs.FavoritiesBox ),
          builder: (BuildContext context, Box box) {
            var data = (box.values.toList());
            print(data);
            // return Text("dflj");
            return _buildGridView(data, size);
          },
        ));
  }

  _buildGridView(values, Size size) {
    if (values.length == 0) {
      return Center(child: Text(
        AppLocale.of(context).getTranslated("favoritie_is_empty")
      ));
    } else {
      return GridView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel model = values[index];
          return _cardProduct(model, size, index);
          // return Text(model.name);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 2 / 2,
          crossAxisCount: 2,
          mainAxisSpacing: 2 / 4,
        ),
      );
    }
  }

  _cardProduct(ProductModel model, Size size, int index) {
    print(model.image);
    String descf = model.desc;
    if (model.desc.length >= 20) descf = model.desc.substring(0, 20) + " ...";
    return Container(
      // height: size.height * 0.2,
      margin: EdgeInsets.all(10),
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
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(model.image),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  await Hive.box( Boxs.FavoritiesBox ).deleteAt(index);
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
                Getx.of(context).toGet(ProductPage(model: model));
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
