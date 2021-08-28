import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/res/res_pro_cele_cate.dart';
import 'package:myapp3/src/model/model_list_grid_product.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class ProductsView extends StatefulWidget {
  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(title: "", context: context),
      body: StreamBuilder(
        stream: ResCategoryProductCelebrities.products().asStream(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ModelListGridProduct.grid(size, snapshot.data.products);
          } else if (snapshot.hasError) {
            return WidgetFuture.error(context, () => setState(() {}));
          } else {
            return WidgetFuture.loading();
          }
        },
      ),
    );
  }
}
