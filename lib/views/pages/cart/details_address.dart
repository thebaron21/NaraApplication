import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/address_rxdart_bloc.dart';
import 'package:myapp3/core/controller/cart_shopping.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/address_model.dart';
import 'package:myapp3/core/repoitorites/address_repository.dart';
import 'package:myapp3/views/pages/payment/payment_page.dart';
import 'package:provider/provider.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({Key key}) : super(key: key);

  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  
  Widget _design(Size size, TextEditingController controller, String hint) {
    return Container(
      width: size.width,
      height: size.height * 0.06,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Color(0xFF333333).withOpacity(0.08))
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// [Size] => [Line]
  get line => Divider(
        color: Colors.black.withOpacity(0.2),
        thickness: 0.5,
        height: 20,
      );

  _text(String text) => Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: Color(0xFF333333),
          fontSize: 17,
        ),
      );

  /// [logic]
  @override
  void initState() {
    super.initState();
    addressRxdartBloc.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cart = Provider.of<Cart>(context, listen: false);
    int totalPrice = 0;
    var d = Hive.box(Boxs.CartItem);
    d.values.forEach((element) {
      totalPrice = totalPrice + (element.toMap()["totalPrice"] as int).toInt();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFF333333),
              width: size.width,
              height: size.height * 0.06,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocale.of(context).getTranslated("details_address"),
                      style: TextStyle(color: Colors.white)),
                  Text("2/3", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  AppLocale.of(context).getTranslated("details_address"),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: size.width * 0.9,
                // height: size.height * 0.55,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: StreamBuilder<AddressRepository>(
                    stream: addressRxdartBloc.getsubject.stream,
                    builder:
                        // ignore: missing_return
                        (context, AsyncSnapshot<AddressRepository> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.addressModel != null &&
                            snapshot.data.error == "") {
                          return _buildDataAddress(
                              size, snapshot.data.addressModel);
                        } else {
                          return _buildError(snapshot.data.error);
                        }
                      } else if (snapshot.hasError) {
                        return _buildError(snapshot.error);
                      } else {
                        return _buildLoading();
                      }
                    }),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              width: size.width * 0.9,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5, color: Color(0xFF333333).withOpacity(0.08))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocale.of(context).getTranslated("total_price"),
                  ),
                  Text("$totalPrice")
                ],
              ),
            ),
            InkWell(
              onTap: () async {                
                Getx.of(context).toGet(PaymentPage());
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataAddress(Size size, AddressModel addressModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: size.height * 0.04),
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
