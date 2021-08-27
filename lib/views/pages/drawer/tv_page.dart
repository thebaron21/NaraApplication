import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/views/widgets/row_product.dart';

class TVPage extends StatefulWidget {
  const TVPage({Key key}) : super(key: key);

  @override
  _TVPageState createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
  String video = "";
  String image =
      "from http://larra.xyz/storage/app/public/uploads/Product/LJXoEUFXZo8ZLVbPrM8fNy4JhgyDClGWuD53S0xc.jpg";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(
        title: AppLocale.of(context).getTranslated("watchs"),
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _heroVideo(video, size),
            _buildGridView(size),
          ],
        ),
      ),
    );
  }

  _heroVideo(String video, Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.35,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  _buildGridView(Size size) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _card(index: index, image: image);
      },
    );
  }

  // ignore: unused_element
  _card({String image, index, model}) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}
