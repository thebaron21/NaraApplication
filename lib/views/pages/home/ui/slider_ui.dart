import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/categories_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/categories_model.dart';
import 'package:myapp3/core/repoitorites/categories_repoitory.dart';
import 'package:myapp3/views/pages/categories/category_id.dart';
import 'package:myapp3/views/pages/info/not_connected.dart';
import 'package:myapp3/views/widgets/network_widget.dart';
import 'package:page_indicator/page_indicator.dart';

class SliderUI extends StatefulWidget {
  const SliderUI({Key key}) : super(key: key);

  @override
  _SliderUIState createState() => _SliderUIState();
}

class _SliderUIState extends State<SliderUI> {
  PageController controller;

  GlobalKey<PageContainerState> key = GlobalKey();

  int counter = 0;

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_statements
    sliderRxdartBloc.getOneCategory("5");
    controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    sliderRxdartBloc.subjectOneCategory.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<CategoriesRespoitory>(
      stream: sliderRxdartBloc.subjectOneCategory.stream,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<CategoriesRespoitory> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null &&
              snapshot.data.categories.length >= 0) {
            Getx.of(context).toGet(NotConnectedPage());
            return _buildWidgetError(size, snapshot.data.error);
          } else if (snapshot.data.exception != null &&
              snapshot.data.error == null &&
              snapshot.data.categories.length >= 0) {
            return _buildWidgetException(size, snapshot.data.exception);
          } else {
            return _buildWidgetCategories(size, snapshot.data.categories);
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

  Widget _buildWidgetCategories(size, List<CategoryModel> categories) {
    return Container(
      width: size.width,
      height: size.height * 0.34,
      child: PageIndicatorContainer(
        key: key,
        length: categories.length,
        align: IndicatorAlign.bottom,
        indicatorSpace: 5.0,
        padding: const EdgeInsets.all(10),
        indicatorColor: Colors.white,
        indicatorSelectorColor: kcPrimaryColor,
        shape: IndicatorShape.circle(size: 10),
        child: PageView.builder(
          controller: controller,
          itemCount: categories.length,
          itemBuilder: (context, int index) {
            return InkWell(
              onTap: () {
                Getx.of(context).toGet(CategoryID(category: categories[index]));
              },
              child: Container(
                width: size.width,
                height: size.height * 0.34,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: CustomeNetWork(image: categories[index].image),
              ),
            );
          },
        ),
      ),
    );
  }
}
