import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hive/hive.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/home_function.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_auth.dart';
import 'package:myapp3/src/view/app_nara.dart';

import 'widgets/box_button.dart';
import 'widgets/box_input_field.dart';

// ignore: must_be_immutable
class ResetView extends StatefulWidget {
  String email;
  ResetView({this.email});

  @override
  _ResetViewState createState() => _ResetViewState();
}

class _ResetViewState extends State<ResetView> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController code = TextEditingController();

  bool isLoading = false;
  String title = "Verification Code";
  String subTitle = "please enter the OTP sent to your\n device";

  /// Return Title label
  get _getTitleText {
    return new Text(
      title,
      textAlign: TextAlign.left,
      style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    );
  }

  /// Return subTitle label
  get _getSubtitleText {
    return new Text(
      subTitle,
      textAlign: TextAlign.left,
      style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _heightSeperator = 22;
    // RestPasswordEvent
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("reset_pass"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: _heightSeperator,
                ),
                _getTitleText,
                _getSubtitleText,
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: kcPrimaryColor,
                  showFieldAsBox: true,
                  onCodeChanged: (String cod) {
                    if (code.text.length <= 4) {
                      setState(() => code.text = code.text + cod);
                    } else if (code.text.length >= 4) {
                      code.clear();
                    }
                  },
                ),
                SizedBox(
                  height: _heightSeperator,
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: BoxInputField(
                      controller: password,
                      placeholder: 'كلمه المرور',
                      password: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: _heightSeperator,
                ),
                BoxInputField(
                  controller: confirmPassword,
                  placeholder: 'تاكييد كلمه المرور',
                  password: true,
                ),
                SizedBox(
                  height: _heightSeperator * 3,
                ),
                BoxButton(
                  busy: isLoading,
                  title: 'حفظ التغييرات',
                  onTap: saveChange,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveChange() async {
    print(code.text);
    if (password.text == confirmPassword.text) {
      setState(() => isLoading = true);
      var data = await ResAuth.reset(
        otp: code.text,
        email: widget.email,
        password: password.text,
      );
      if (data is DioError) {
        print(data.response.data);
      } else {
        if (data["data"] != null) {
          await Hive.box(EndBoxs.NaraApp).put("token", data["data"]["token"]);
          RouterF.of(context).push(
            () => AppNara(
              init: Nav.MYBAD,
            ),
          );
        }
      }
      setState(() => isLoading = false);
    }
  }
}
