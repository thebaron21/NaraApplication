import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/categories_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/categories_model.dart';
import 'package:myapp3/core/repoitorites/categories_repoitory.dart';
import 'package:myapp3/views/pages/categories/category_id.dart';
import 'package:myapp3/views/widgets/network_widget.dart';
import 'package:bordered_text/bordered_text.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({Key key}) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  void initState() {
    super.initState();
    oneCategory.getOneCategory("1");
  }

  @override
  void dispose() {
    super.dispose();
    oneCategory.subjectOneCategory.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<CategoriesRespoitory>(
      stream: oneCategory.subjectOneCategory.stream,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<CategoriesRespoitory> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null &&
              snapshot.data.categories.length <= 0) {
            return _buildWidgetError(size, snapshot.data.error);
          } else if (snapshot.data.exception != null &&
              snapshot.data.error == null &&
              snapshot.data.categories.length <= 0) {
            return _buildWidgetException(size, snapshot.data.exception);
          } else {
            return _card(snapshot.data.categories[0], size);
          }
        } else if (snapshot.hasError) {
          return _buildError(size, snapshot.error);
        } else {
          return _buildWidgetLoading(size);
        }
      },
    );
  }

  Widget _buildWidgetError(Size size, Map<String, dynamic> error) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: Center(
        child: Text(error.toString()),
      ),
    );
  }

  Widget _buildWidgetException(Size size, String exception) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: Center(
        child: Text(exception),
      ),
    );
  }

  Widget _buildError(Size size, Object error) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: Center(
        child: Text(error.toString()),
      ),
    );
  }

  Widget _buildWidgetLoading(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: kcPrimaryColor,
        ),
      ),
    );
  }

  _card(CategoryModel model, Size size) {
    return InkWell(
      onTap: () {
        Getx.of(context).toGet(CategoryID(category: model));
      },
      child: Container(
        width: size.width * 0.95,
        height: size.height * 0.3,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.3,
              child: CustomeNetWork(
                image: model.image,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BorderedText(
                    strokeWidth: 1.5,
                    child: Text(
                      model.name,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                        color:Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: size.width * 0.5,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocale.of(context).getTranslated("discover_now"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
