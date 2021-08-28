import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_auth.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';

import 'forgot_password.dart';
import 'register_screen.dart';
import 'widgets/box_button.dart';
import 'widgets/box_input_field.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _loading = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _heightSeperator = 22;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(
        title: "",
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: _heightSeperator * 2,
              ),
              Form(
                child: Column(
                  children: [
                    BoxInputField(
                      controller: email,
                      password: false,
                      placeholder:
                          AppLocale.of(context).getTranslated("login_email"),
                      trailing: Icon(Icons.mail_outline),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BoxInputField(
                      controller: password,
                      placeholder:
                          AppLocale.of(context).getTranslated("login_passw"),
                      password: true,
                      trailing: Icon(Icons.lock),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(),
                    ),
                    BoxButton(
                      busy: _loading,
                      disabled: _loading,
                      onTap: login,
                      title: AppLocale.of(context).getTranslated("login_btn"),
                    ),
                    SizedBox(
                      height: _heightSeperator,
                    ),
                    FlatButton(
                      onPressed: () {
                        RouterF.of(context).push(() => ForgotPasswordView());
                      },
                      child: Text(
                        AppLocale.of(context).getTranslated("login_forgot"),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          locale: Locale("en"),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _heightSeperator - 21,
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      text: AppLocale.of(context)
                          .getTranslated("sign_in_with_facebook"),
                      onPressed: () async {},
                    ),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () async {},
                      text: AppLocale.of(context)
                          .getTranslated("sign_in_with_google"),
                    ),
                    FlatButton(
                      onPressed: () {
                        RouterF.of(context).push(() => RegisterView());
                      },
                      child: Text(
                        AppLocale.of(context).getTranslated("login_dont_have"),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    setState(() => _loading = true);
    var data = await ResAuth.login(email: email.text, password: password.text);

    setState(() => _loading = false);
  }
}
