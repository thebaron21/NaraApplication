import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/core/bloc/categories/categories_bloc.dart';
import 'package:myapp3/core/controller/cart_shopping.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/cart_model.dart';
import 'package:myapp3/core/model/product_model.dart';
import 'package:myapp3/views/pages/home/ui/product_ui.dart';
import 'package:myapp3/views/widgets/row_product.dart';
import 'package:provider/provider.dart';
import '../../nara_app.dart';
import '../../widgets/product_widget.dart';

class ProductPage extends StatefulWidget {
  final ProductModel model;
  const ProductPage({Key key, this.model}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Color primaryColor = Color(0xFF448375);
  Color kcPrimaryColor = Color(0xFF6B2592);

  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(GetProductsOfCategory("2"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: widget.model.name,
        isCart: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSliderImage(size, [widget.model.image]),
            customDetailsProduct(
              size,
              nameBrand: widget.model.name,
              price: widget.model.price,
              desc: widget.model.desc,
              name: widget.model.name,
            ),
            //--------------------------------------
            Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.3),
            ),
            customYouMayAlsoLike(size),
            //--------------------------------------
            SizedBox(
              width: size.width,
              height: size.height * 0.07,
            )
          ],
        ),
      ),
      bottomSheet: customButtonSheet(
        context,
        size,
        widget.model,
        onTap: () async {
          ProductModel data = widget.model;
          CartItemModel coverModel = CartItemModel(
            id: data.id.toString(),
            count: 1,
            name: data.name,
            price: int.parse(data.price),
            totalPrice: int.parse(data.price),
            image: data.image,
            desc: data.desc,
          );
          var cartBox = Hive.box(Boxs.CartItem);
          var f = cartBox.values
              .toList()
              .where((element) => coverModel.id == element.id);
          if (f.length == 0) {
            await cartBox.add(coverModel);
          } else {
            Getx.of(context).toGetNotBack(NaraApp(init: Nav.MYBAD));
          }
        },
        onTapFavorite: () async {
          int index = -1;
          var f = Hive.box(Boxs.FavoritiesBox).values.contains(widget.model);
          if (f == false) {
            await Hive.box(Boxs.FavoritiesBox).add(widget.model);
          } else {
            for (var i in Hive.box(Boxs.FavoritiesBox).values.toList()) {
              index++;
              if ((i as ProductModel).toMap()["id"] ==
                  widget.model.toMap()["id"]) {
                Hive.box(Boxs.FavoritiesBox).deleteAt(index);
              }
            }
          }
        },
      ),
    );
  }

  customYouMayAlsoLike(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "مزيد من المنتجات",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            height: 1,
            width: size.width * 0.6,
            color: Colors.black,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: size.height * 0.5,
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is ProductSuccess) {
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: size.width * 0.45,
                          child: CardProduct(
                            onBuy: () {
                              Getx.of(context)
                                  .toGet(BlocProvider<CategoriesBloc>(
                                create: (_) => CategoriesBloc(),
                                lazy: false,
                                child: ProductPage(
                                  model: state.products[index],
                                ),
                              ));
                            },
                            model:state.products[index],
                            image: state.products[index].image,
                            price: state.products[index].price,
                            text: state.products[index].name,
                            desc: state.products[index].desc,
                          ),
                        );
                      });
                } else if (state is CategoriesError) {
                  return Center(child: Text(state.error.toString()));
                } else if (state is CategoriresException) {
                  return Center(child: Text(state.error));
                } else if (state is CategoriesInitial) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: kcPrimaryColor,
                    ),
                  );
                } else if (state is CategortiesLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: kcPrimaryColor,
                  ));
                }
              },
            ),
          ),
          SizedBox(
            width: size.width,
            height: size.height * 0.01,
          )
        ],
      ),
    );
  }

  Icon iconStar = Icon(Icons.star_border_purple500_sharp);
  Padding customDetailsProduct(Size size,
      {String nameBrand, String price, String desc, String name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          SizedBox(
            height: 10,
          ),
          _customNameBrand(nameBrand, size),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              iconStar,
              iconStar,
              iconStar,
              iconStar,
              iconStar,
              SizedBox(width: 10),
              Text(
                "تقييم المنتج",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Text(
              "$price KWD ",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Divider(
            thickness: 1,
            color: Colors.black.withOpacity(0.3),
          ),
          Text(
            "الوصف",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "$desc",
          )
        ],
      ),
    );
  }

  Container _customNameBrand(String nameBrand, Size size) {
    return Container(
      width: size.width * 0.35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                "الماركة",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              height: 35,
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  nameBrand,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
