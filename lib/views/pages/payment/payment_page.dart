import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:hive/hive.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/address_rxdart_bloc.dart';
import 'package:myapp3/core/controller/cart_shopping.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/address_model.dart';
import 'package:myapp3/core/repoitorites/address_repository.dart';
import 'package:myapp3/core/response/address_reponse.dart';
import 'package:myapp3/core/response/order_response.dart';
import 'package:myapp3/views/nara_app.dart';
import 'package:myapp3/views/pages/cart/payment_page_view.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  /// [Data] of Radio
  String tPank = "pank";
  String tCredit = "credit";
  String paymentInRecive = "cash";

  String groupValue = "";
  _radio(String value) => Radio(
        value: value,
        groupValue: groupValue,
        onChanged: (v) => setState(() => groupValue = v),
      );
  _text(String text) => Text(
        text,
        style: TextStyle(fontSize: 18),
      );

  _bar(Size size) => Container(
        color: Color(0xFF333333),
        width: size.width,
        height: size.height * 0.06,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocale.of(context).getTranslated("select_type_payment"),
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "3/3",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  /// [Size] => [Line]
  get line => Divider(
        color: Color(0xFF333333).withOpacity(0.3),
        thickness: 0.5,
        height: 15,
      );

  OrderResponse _response = OrderResponse();
  @override
  void initState() {
    super.initState();
    addressRxdartBloc.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocale.of(context).getTranslated("my_bag"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bar(size),
            SizedBox(height: 30),

            /// [Type Card]
            _typeCard(size),
            SizedBox(height: size.height * 0.05),
            _price(size, cart),
            SizedBox(height: size.height * 0.05),
            _address(size),
            SizedBox(height: size.height * 0.025),
            _btnSetOrder(size),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }

  _typeCard(Size size) {
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFF333333).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Row(children: [
          //   _radio(tPank),
          //   _text(
          //     AppLocale.of(context).getTranslated("bank"),
          //   )
          // ]),
          // line,
          Row(children: [
            _radio(tCredit),
            _text(
              AppLocale.of(context).getTranslated("credit_card"),
            )
          ]),
          line,
          Row(children: [
            _radio(paymentInRecive),
            _text(
              AppLocale.of(context).getTranslated("payment_to_recive"),
            ),
          ]),
        ],
      ),
    );
  }

  _price(Size size, Cart cart) {
    int totalPrice = 0;
    var d = Hive.box(Boxs.CartItem);
    d.values.forEach((element) {
      totalPrice = totalPrice + (element.toMap()["totalPrice"] as int).toInt();
    });
    return Container(
      width: size.width * 0.9,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFF333333).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _text(
                AppLocale.of(context).getTranslated("price"),
              ),
              _text("$totalPrice"),
            ],
          ),
          line,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _text(
                AppLocale.of(context).getTranslated("delivery"),
              ),
              _text("${30}"),
            ],
          ),
          line,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _text(
              AppLocale.of(context).getTranslated("total_price"),
            ),
            _text("${totalPrice + 30}"),
          ])
        ],
      ),
    );
  }

  _address(Size size) {
    return Container(
      width: size.width * 0.9,
      // height: size.height * 0.55,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFF333333).withOpacity(0.3)),
        color: Colors.white,
      ),
      child: StreamBuilder<AddressRepository>(
        stream: addressRxdartBloc.getsubject.stream,
        builder:
            // ignore: missing_return
            (context, AsyncSnapshot<AddressRepository> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.addressModel != null &&
                snapshot.data.error == "") {
              return _buildDataAddress(size, snapshot.data.addressModel);
            } else {
              return _buildError(snapshot.data.error);
            }
          } else if (snapshot.hasError) {
            return _buildError(snapshot.error);
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  AddressResponse _responseAddress = AddressResponse();
  bool isLoading = false;
  _btnSetOrder(Size size) {
    return isLoading == false
        ? InkWell(
            onTap: () async {
              setState(() => isLoading = true);
              var data = await _responseAddress.getAddress();
              var idAddress = data.addressModel.toMap()["id"];
              String token = Hive.box(Boxs.NaraApp).get("token");
              if (groupValue == "cash") {
                var data =
                    await _response.setOrder(int.parse(idAddress), groupValue);
                if (data == true) {
                  Getx.of(context).toGet(NaraApp(token: token));
                } else {
                  Getx.of(context).message("خطأ", "خطأ غير معروف");
                }
              } else if (groupValue == "credit") {
                var data = await _response.setOrderCredit(
                    int.parse(idAddress), "credit");
                if (data != null)
                  Getx.of(context).toGetNotBack(WebViewPage(url: data));
                else
                  Getx.of(context).message("خطأ", "خطأ غير معروف");
              }
              setState(() => isLoading = false);
            },
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.065,
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                AppLocale.of(context).getTranslated("add_details_payment"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        : Container(
            height: size.height * 0.065,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            decoration: BoxDecoration(
              color: kcPrimaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              backgroundColor: Colors.teal,
            ));
  }

  Widget _buildDataAddress(Size size, AddressModel addressModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _text(
            "${AppLocale.of(context).getTranslated("username")} :    ${addressModel.name} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("address")} :    ${addressModel.address} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("city")}     :    ${addressModel.city} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("state")} :    ${addressModel.state} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("street")}  :    ${addressModel.street} "),
        line,
        _text(
            "${AppLocale.of(context).getTranslated("phone_number")} : ${addressModel.phone} "),
      ],
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Text(error),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.teal,
      ),
    );
  }
}
