import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/address_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/address_model.dart';

import 'details_address.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  /// [TextEditingController] Varible
  TextEditingController username = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController street = TextEditingController();

  /// [Widget] of Page
  // ignore: unused_element
  Widget _design(Size size, TextEditingController controller, String hint) {
    return Center(
      child: Container(
        width: size.width,
        height: size.height * 0.07,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Color(0xFF333333).withOpacity(0.08))
          ],
        ),
        child: Center(
          child: TextField(
            controller: controller,
            selectionHeightStyle: BoxHeightStyle.max,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  // _col(Size size) => Column(children: children,) ;

  get line => SizedBox(height: 5);
  _text(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: Color(0xFF333333),
        ),
      );
  @override
  void dispose() {
    super.dispose();

    addressRxdartBloc.setSubject.close();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("add_address"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF333333),
              width: size.width,
              height: size.height * 0.06,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${AppLocale.of(context).getTranslated("next")}",
                      style: TextStyle(color: Colors.white)),
                  Text("1/3", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///[Username]
                  _text(AppLocale.of(context).getTranslated("username")),
                  line,
                  _design(size, username,
                      AppLocale.of(context).getTranslated("username")),

                  /// [Address]
                  line,
                  _text(AppLocale.of(context).getTranslated("address")),
                  line,
                  _design(size, address,
                      AppLocale.of(context).getTranslated("address")),

                  /// [City]
                  line,
                  _text(AppLocale.of(context).getTranslated("city")),
                  line,
                  _design(
                      size, city, AppLocale.of(context).getTranslated("city")),

                  /// [Phone]
                  line,
                  _text(AppLocale.of(context).getTranslated("phone_number")),
                  line,
                  _design(size, phone,
                      AppLocale.of(context).getTranslated("phone_number")),
                  line,

                  ///[State]
                  _text(AppLocale.of(context).getTranslated("state")),
                  line,
                  _design(size, state,
                      AppLocale.of(context).getTranslated("state")),
                  line,
                  _text(AppLocale.of(context).getTranslated("street")),
                  line,
                  _design(size, street,
                      AppLocale.of(context).getTranslated("street")),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLoading == false
          ? InkWell(
              onTap: () async {
                print("Startinh ...");
                setState(() => isLoading = true);
                await addressRxdartBloc.setAddress(
                  AddressModel(
                    username.text,
                    address.text,
                    phone.text,
                    city.text,
                    state.text,
                    street.text,
                  ),
                );
                addressRxdartBloc.setSubject.stream.listen((event) {
                  if (event == false) {
                    setState(() => isLoading = false);
                    Getx.of(context).message(
                      AppLocale.of(context).getTranslated("error"),
                      AppLocale.of(context).getTranslated("error"),
                    );
                  } else {
                    setState(() => isLoading = false);
                    Getx.of(context).toGet(AddressDetails());
                  }
                });
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
                  AppLocale.of(context).getTranslated("next"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              ),
            ),
    );
  }
}
