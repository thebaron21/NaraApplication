import 'package:flutter/material.dart';
import 'package:myapp3/src/view/pages/home/widgets/widget_slider.dart';
import 'package:myapp3/src/view/pages/home/widgets/widget_top_brand.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';

import 'widgets/widget_celebrities.dart';
import 'widgets/widget_product.dart';
import 'widgets/widget_top_cateogries.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  appBar(
        centerTitle: true,
        isLogo: true,
        context: context,
        isCart: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SliderHome.sliderFuture(size, controller, () => setState(() {})),
            CelebritiesHome.celebritiesFuture(size, () => setState(() {})),
            ProductHome.productsFuture(size, () => setState(() {})),
            TopCategoriesHome.categories(size, () => setState(() {})),
            TopBrandHome.brands(size, () => setState(() {})),
          ],
        ),
      ),
    );
  }
}
