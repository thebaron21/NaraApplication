import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/auth/authenticationo_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/controller/hive_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../nara_app.dart';
import 'forgot_password.dart';
import 'register_screen.dart';
import 'widgets/box_button.dart';
import 'widgets/box_input_field.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // AuthenticationResponse _authenticationResponse;


  Future<void> setToken({@required String token}) async {
    await Hive.box( Boxs.NaraApp ).put("token", token);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _loading = false;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  @override
  Widget build(BuildContext context) {
    double _heightSeperator = 22;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(AppLocale.of(context).getTranslated("login_title"),
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          setState(() {
            _loading = false;
          });
          if (state is AuthenticationError) {
            messageBox(AppLocale.of(context).getTranslated("error"),
                state.error.values.toList());
          } else if (state is AuthentiationException) {
            messageBoxException(
                AppLocale.of(context).getTranslated("error"), state.error);
          } else if (state is AuthenticationSuccess) {
            setToken(token: state.token);

            Getx.of(context).toGetNotBack(NaraApp(token: state.token));
          }
        },
        child: SingleChildScrollView(
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
                  key: _formKey,
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
                        password: isShow,
                        trailing: showPassword(),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(),
                      ),
                      _loading == false
                          ? BoxButton(
                              onTap: () async {
                                setState(() {
                                  _loading = true;
                                });
                                context
                                    .read<AuthenticationBloc>()
                                    .add(Login(email.text, password.text));
                              },
                              title: AppLocale.of(context)
                                  .getTranslated("login_btn"),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                backgroundColor: kcPrimaryColor,
                              ),
                            ),
                      SizedBox(
                        height: _heightSeperator,
                      ),
                      FlatButton(
                        onPressed: () {
                          Getx.of(context).toGet(ForgotPasswordPage());
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
                        onPressed: () async {
                          var result = await FacebookAuth.instance.login();

                          switch (result.status) {
                            case LoginStatus.success:
                              print(
                                  '''
                            Logged in!
                            
                            Token: ${result.accessToken.token}
                            User id: ${result.accessToken.userId}
                            Expires: ${result.accessToken.expires}
                            Permissions: ${result.accessToken.toJson()}
                            Declined permissions: ${result.accessToken.declinedPermissions}
                                 ''');
                              break;
                            case LoginStatus.cancelled:
                              print("Cemcelled");
                              break;
                            case LoginStatus.failed:
                              print("Failed");
                              break;
                            case LoginStatus.operationInProgress:
                              print("Operation In Progress");
                              break;
                          }
                        },
                      ),
                      SignInButton(
                        Buttons.Google,
                        onPressed: () async {},
                        text: AppLocale.of(context)
                            .getTranslated("sign_in_with_google"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Getx.of(context).toGet(RegisterScreen());
                        },
                        child: Text(
                          AppLocale.of(context)
                              .getTranslated("login_dont_have"),
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
      ),
    );
  }

  bool isShow = false;
  Icon iconShow = Icon(Icons.lock);
  showPassword() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isShow == true) {
            isShow = false;
            iconShow = Icon(Icons.lock_open);
          } else {
            isShow = true;
            iconShow = Icon(Icons.lock);
          }
        });
      },
      child: iconShow,
    );
  }

  messageBox(String title, List message) {
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

  messageBoxException(String title, String message) {
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
