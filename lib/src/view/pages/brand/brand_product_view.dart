
import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/model/model_brand.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';

import 'widgets/widget_product_brand.dart';

class BrandProductView extends StatefulWidget {
  final ModelBrand brand;

  const BrandProductView({Key key, this.brand}) : super(key: key);
  @override
  _BrandProductViewState createState() => _BrandProductViewState();
}

class _BrandProductViewState extends State<BrandProductView> {
   // ProductDetailsView
  
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(
        title: widget.brand.name,
        context: context,
        isCart: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WidgetProductBrand.hero(widget.brand.image, size),
            WidgetProductBrand.space(size),
            WidgetProductBrand.brandsFuture(size, ()=> setState((){}), widget.brand.id.toString())
          ],
        ),
      ),
    );
  }
}