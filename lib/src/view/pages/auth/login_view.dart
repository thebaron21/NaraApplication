import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/end_boxs.dart';
import 'package:myapp3/src/logic/function/home_function.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_auth.dart';
import 'package:myapp3/src/view/app_nara.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';
import '../../../logic/res/res_auth.dart';
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
                      onPressed: loginFacebook,
                    ),
                    SignInButton(
                      Buttons.Google,
                      onPressed: onGoogle,
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
 if (data["status"] == true) {
        await Hive.box(EndBoxs.NaraApp).put("token", data["token"]);
        RouterF.of(context).push(() => AppNara(init: Nav.HOME));
      } else {
        RouterF.of(context).message("خطأ", data["errors"].toString());
      }
    setState(() => _loading = false);
  }

  onGoogle() async {
    try {
      setState(() => _loading = true);
      // final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      print("Google Sign IN ${await _googleSignIn.isSignedIn()}");
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication d = await googleSignInAccount.authentication;

      print("Email : ${d.idToken}");
      print("ID: ${googleSignInAccount.id }");
      print("DisplayName: ${googleSignInAccount.displayName}");
      print("Email: ${googleSignInAccount.email}");
      var data = await ResAuth.login(email: googleSignInAccount.email, password: googleSignInAccount.id.toString());
      if (data["status"] == true) {
        await Hive.box(EndBoxs.NaraApp).put("token", data["token"]);
        RouterF.of(context).push(() => AppNara(init: Nav.HOME));
      } else {
        RouterF.of(context).message("خطأ", data["errors"].toString());
      }
      setState(() => _loading = false);
    } catch (e) {
      setState(() => _loading = false);
      throw e;
    }
  }

  loginFacebook() async {
    setState(() => _loading = true);
    FacebookLogin _facebookLogin = FacebookLogin();
    FacebookLoginResult login = await _facebookLogin.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile,
      FacebookPermission.userLikes
    ]);
    switch (login.status) {
      case FacebookLoginStatus.success:
        var data = await ResAuth.loginFB(email: login.accessToken.userId);
         if (data["status"] == true) {
        Hive.box(EndBoxs.NaraApp).put("token", data["token"]);
        RouterF.of(context).push(() => AppNara(init: Nav.HOME));
      } else {
        RouterF.of(context).message("خطأ", data["errors"].toString());
      }
      setState(() => _loading = false);
        break;
      case FacebookLoginStatus.cancel:
        RouterF.of(context).message("خطأ", "خطأ في تسجيل دخول");
        break;
      case FacebookLoginStatus.error:
        RouterF.of(context).message("خطأ", "خطأ في تسجيل دخول");
        break;
    }

    setState(() => _loading = false);
  }
}
