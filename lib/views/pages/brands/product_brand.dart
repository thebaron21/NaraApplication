import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/bloc/rxdartBloc/brand_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/brand_model.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/core/repoitorites/brand_repository.dart';
import 'package:myapp3/core/response/brand_response.dart';
import 'package:myapp3/views/pages/product/product.dart';
import 'package:myapp3/views/widgets/card_product.dart';
import 'package:myapp3/views/widgets/row_product.dart';

class BrandProductPage extends StatefulWidget {
  final BrandModel model;
  const BrandProductPage({Key key, this.model}) : super(key: key);

  @override
  _BrandProductPageState createState() => _BrandProductPageState();
}

class _BrandProductPageState extends State<BrandProductPage> {
  @override
  void initState() {
    super.initState();
    brandRxdartBloc.getProductBrand(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(
        title: widget.model.name,
        context: context,
        isCart: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.model.image),
                ),
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.05,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            StreamBuilder(
              stream: brandRxdartBloc.productBrand.stream,
              builder: (BuildContext context,
                  AsyncSnapshot<BrandRepository2> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.brands.length > 0 &&
                      snapshot.data.error == "") {
                    return _buildGridView(snapshot.data.brands, size);
                  } else {
                    return _buildErrorWidget(snapshot.data.error);
                  }
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error);
                } else {
                  return _buildLoading();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(backgroundColor: Colors.teal),
    );
  }

  Widget _buildErrorWidget(error) {
    return Center(child: Text(error.toString()));
  }

  Widget _buildGridView(List<BrandModel2> brands, Size size) {
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: brands.length,
      itemBuilder: (BuildContext context, int index) {
        return CardProduct(
          onTap: () {
            Getx.of(context).toGet(BlocProvider<CategoriesBloc>(
              create: (_) => CategoriesBloc(),
              lazy: false,
              child: ProductPage(
                model: ProductModel(
                  id: brands[index].id,
                  image: brands[index].image,
                  name: brands[index].name,
                  desc: brands[index].desc,
                  price: brands[index].price,
                ),
              ),
            ));
          },
          id: brands[index].id,
          text: brands[index].name,
          image: brands[index].image,
          price: brands[index].price,
          desc: brands[index].desc,
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 5,
        mainAxisSpacing: 10,
        // crossAxisSpacing: 10,
      ),
    );
  }
}
