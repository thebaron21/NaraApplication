import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_address.dart';
import 'package:myapp3/src/view/pages/auth/widgets/box_button.dart';
import 'package:myapp3/src/view/pages/auth/widgets/box_input_field.dart';
import 'package:country_list/country_list.dart';

import 'details_address.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key key}) : super(key: key);

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  /// [TextEditingController] Varible
  TextEditingController username = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  String dropdownvalue = "Select Country";
  TextEditingController street = TextEditingController();
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(3),
  );

  /// [Widget] of Page

  // _col(Size size) => Column(children: children,) ;

  get line => SizedBox(height: 5);

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
                  line,
                  BoxInputField(
                    controller: username,
                    placeholder:
                        AppLocale.of(context).getTranslated("username"),
                  ),
                  line,

                  /// [Address]
                  BoxInputField(
                    controller: address,
                    placeholder: AppLocale.of(context).getTranslated("address"),
                  ),
                  line,

                  /// [City]
                  BoxInputField(
                    controller: city,
                    placeholder: AppLocale.of(context).getTranslated("city"),
                  ),
                  line,

                  /// [Phone]
                  BoxInputField(
                    controller: phone,
                    placeholder:
                        AppLocale.of(context).getTranslated("phone_number"),
                  ),
                  line,

                  ///[State]
//                   BoxInputField(
//                     controller: state,
//                     placeholder: AppLocale.of(context).getTranslated("state"),
//                   ),  EdgeInsets.symmetric(horizontal: 10),
//                   Container(
//                    child:ListView.builder(
//     itemCount: Countries.list.length,
//     itemBuilder: (_, position) {
//         Country country = Countries.list[position];
//         return Text(country.name);
//     },
//     ),
//                   ),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 7),
                    // width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      //  border: circularBorder.copyWith(
                      //   //  borderSide: BorderSide(color: kcLightGreyColor),
                      //  ),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ),
                    child: DropdownButton(
                      value: dropdownvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: Countries.list.map((Country items) {
                        return DropdownMenuItem(
                            value: items.name, child: Text(items.name));
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownvalue = newValue;
                        });
                      },
                    ),
                  ),
                  line,
                  BoxInputField(
                    controller: street,
                    placeholder: AppLocale.of(context).getTranslated("street"),
                  ),
                  line,
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 58,
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: BoxButton(
            title: "إضافة العنوان",
            busy: isLoading,
            disabled: isLoading,
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  void onTap() async {
    setState(() => isLoading = true);
    try {
      var data = await ResAddress.setAddrss(
        name: username.text,
        city: city.text,
        address: address.text,
        street: street.text,
        phone: phone.text,
        state: dropdownvalue,
      );
      if (data["statusCode"] == 200) {
        RouterF.of(context).push(() => AddressDetailsView());
      }
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      if (e is DioError) {
        if (e.response.statusCode == 422) {
          RouterF.of(context)
              .message("خطأ", e.response.data["errors"]["phone"][0].toString());
        }
      }
    }
    setState(() => isLoading = false);
  }
}
