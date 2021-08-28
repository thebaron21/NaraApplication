import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_auth.dart';

import 'reset_password.dart';
import 'widgets/box_button.dart';
import 'widgets/box_input_field.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  Color primaryColor = Color(0xFF448375);
  Color kcPrimaryColor = Color(0xFF6B2592);
  TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("forgot_you_password"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.14,
                ),
                Text(
                  AppLocale.of(context).getTranslated("content_page_forgot"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BoxInputField(
                    controller: _emailController,
                    password: false,
                    placeholder: AppLocale.of(context).getTranslated("email"),
                    trailing: Icon(Icons.mail_outline),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                BoxButton(
                  busy: isLoading,
                  disabled: isLoading,
                  title: AppLocale.of(context).getTranslated("next"),
                  onTap: onTap,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap() async {
    setState(() => isLoading = true);
    var data = await ResAuth.forgot(email: _emailController.text);

    if (data is DioError) {
      if (data.response.data["errors"] != null) {
        RouterF.of(context)
            .message("خطأ", data.response.data["errors"]["email"].toString());
      }
    } else if (data["statusCode"] == 202) {
      RouterF.of(context).push(() => ResetView(email: _emailController.text));
    }
    setState(() => isLoading = false);
  }
}
