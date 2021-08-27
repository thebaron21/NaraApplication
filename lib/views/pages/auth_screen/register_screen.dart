import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/auth/authenticationo_bloc.dart';
import 'package:myapp3/core/controller/control.dart';

import 'login_screen.dart';
import 'widgets/box_button.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  bool isShow = false;

  String iconShow = "Hide";

  showPassword() {
    return GestureDetector(
      onTap: () {
        if (isShow == true) {
          isShow = false;
          iconShow = "Hide";
        } else {
          isShow = true;
          iconShow = "Show";
        }
      },
      child: Text(iconShow),
    );
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double _heightSeperator = 20;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("register"),
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBloc(),
        listener: (context, state) {
          if (state is AuthenticationError) {
            messageBox(AppLocale.of(context).getTranslated("error"),
                state.error.values.toList(), context);
          } else if (state is AuthentiationException) {
            messageBoxException(AppLocale.of(context).getTranslated("error"),
                state.error, context);
          } else if (state is AuthenticationSuccess) {
            // messageBoxException("Token", state.token, context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _heightSeperator * 2,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[400].withOpacity(0.7),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _designTextField(
                        size,
                        hint: AppLocale.of(context).getTranslated("username"),
                        password: false,
                        controller: name,
                      ),
                      Divider(
                        height: 5,
                        thickness: .8,
                        color: Colors.grey[200],
                      ),
                      _designTextField(
                        size,
                        hint:
                            AppLocale.of(context).getTranslated("login_email"),
                        password: false,
                        controller: email,
                      ),
                      Divider(
                        height: 2,
                        thickness: .8,
                        color: Colors.grey[200],
                      ),
                      _designTextField(
                        size,
                        hint:
                            AppLocale.of(context).getTranslated("login_passw"),
                        password: isShow,
                        controller: password,
                        trailing: showPassword(),
                      ),
                      Divider(
                        height: 5,
                        thickness: .8,
                        color: Colors.grey[200],
                      ),
                      _designTextField(
                        size,
                        hint: AppLocale.of(context)
                            .getTranslated("password_confirmation"),
                        password: isShow,
                        controller: confirmPassword,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                //-------------Sex
                _selectSex(size),
                SizedBox(
                  height: _heightSeperator * 2,
                ),
                isLoading == false
                    ? BoxButton(
                        title: AppLocale.of(context).getTranslated("sign_up"),
                        onTap: () async {
                          print("Herrr");
                          setState(() => isLoading == true);
                          context.read<AuthenticationBloc>().add(Register(
                                name.text,
                                email.text,
                                password.text,
                                confirmPassword.text,
                              ));
                          setState(() => isLoading == true);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kcPrimaryColor,
                        ),
                      ),

                SizedBox(
                  height: _heightSeperator * 2,
                ),

                Align(
                  alignment: Alignment.center,
                  child: SignInButton(
                    Buttons.Facebook,
                    onPressed: () async {
                      // final fbLogin = FacebookLogin();
                      // var result = await fbLogin.logIn(["email"]);
                      // final token = result.accessToken.token;
                      // print("Token :   , Result : ");
                    },
                    text: AppLocale.of(context)
                        .getTranslated("sign_up_with_facebook"),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: () {},
                    text: AppLocale.of(context)
                        .getTranslated("sign_up_with_google"),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: _alreadyIHave(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int index = 0;

  Widget _selectSex(Size size) {
    return Center(
      child: Container(
        width: size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[400].withOpacity(0.7),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
              onPressed: () {
                if (index == 1)
                  setState(() => index = 0);
                else
                  setState(() => index = 1);
              },
              child: Row(
                children: [
                  Text("Male"),
                  index == 1
                      ? Icon(Icons.check, color: kcAccentColor)
                      : Container(),
                ],
              ),
            ),
            FlatButton(
              minWidth: 70,
              onPressed: () {
                if (index == 2)
                  setState(() => index = 0);
                else
                  setState(() => index = 2);
              },
              child: Row(
                children: [
                  Text("Female"),
                  index == 2
                      ? Icon(Icons.check, color: kcAccentColor)
                      : Container(),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                if (index == 3)
                  setState(() => index = 0);
                else
                  setState(() => index = 3);
              },
              child: Row(
                children: [
                  Text("Later"),
                  index == 3
                      ? Icon(Icons.check, color: kcAccentColor)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _designTextField(Size size,
      {String hint, controller, bool password, Widget trailing}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 7),
          hintText: hint,
          suffix: trailing,
          border: InputBorder.none,
          // border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _alreadyIHave(context) {
    return FlatButton(
      onPressed: () {
        Getx.of(context).toGet(LoginScreen());
      },
      child: Text(
        AppLocale.of(context).getTranslated("already_have"),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  messageBox(String title, List message, context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 100,
            child: Column(
              children: message.map((e) => Text(e.toString())).toList(),
            ),
          ),
        );
      },
    );
  }

  messageBoxException(String title, String message, context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text("$message"),
        );
      },
    );
  }
}
