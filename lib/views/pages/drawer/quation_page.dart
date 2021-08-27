import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/views/widgets/row_product.dart';

class QuationsPage extends StatefulWidget {
  const QuationsPage({ Key key }) : super(key: key);

  @override
  _QuationsPageState createState() => _QuationsPageState();
}

class _QuationsPageState extends State<QuationsPage> {
  @override
  Widget build(BuildContext context) {
    var t = AppLocale.of(context);
    return Scaffold(
      appBar:appBar(
        title:t.getTranslated("quatioins"),
        context:context,
      )
    );
  }
}