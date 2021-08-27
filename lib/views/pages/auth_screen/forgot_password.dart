import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/response/authentication_reponse.dart';
import 'package:myapp3/views/pages/auth_screen/reset_password.dart';
import 'package:myapp3/views/pages/auth_screen/widgets/box_input_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  Color primaryColor = Color(0xFF448375);
  Color kcPrimaryColor = Color(0xFF6B2592);
  TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> _globalForm = GlobalKey<FormState>();
  String errors;
  bool isLoading = false;
  AuthenticationResponse _bloc = AuthenticationResponse();

  @override
  void initState() {
    super.initState();
  }

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
      body:
          SingleChildScrollView(
        child: Form(
          key: _globalForm,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.14,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    AppLocale.of(context).getTranslated("content_page_forgot"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
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
                isLoading == false
                    ? InkWell(
                        onTap: () async {
                          print(_emailController.text);
                          setState(() => isLoading = true);
                          if (_emailController.text != "") {
                            var data = await _bloc.forgetPass(
                                email: _emailController.text);
                            if( data == true ){
                              Getx.of(context).toGet(ResetScreen(email: _emailController.text));
                            }else{
                              Getx.of(context)
                                .message("خطأ", "اكتب البريد الإلكتروني");  
                            }
                            
                            setState(() => isLoading = false);
                          } else {
                            setState(() => isLoading = false);
                            Getx.of(context)
                                .message("خطأ", "اكتب البريد الإلكتروني");
                          }
                        },
                        child: Container(
                          height: size.height * 0.065,
                          width: size.width * 0.85,
                          decoration: BoxDecoration(
                            color: kcPrimaryColor,
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              AppLocale.of(context).getTranslated("next"),
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = .4
                                  ..color = Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kcPrimaryColor,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // saving() {
  //   final _key = _globalForm.currentState;
  //   if (_key.validate() == true) {
  //     _key.save();
  //     print("Email : " + _emailController.text);
  //   } else {
  //     print("Errors : $errors ");
  //     msgBox(context);
  //   }
  // }

  void msgBox(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text(
            AppLocale.of(context).getTranslated("error"),
          ),
          content: Text(
            AppLocale.of(context).getTranslated("error"),
          ),
          actions: [
            FlatButton(
              child: Text(
                AppLocale.of(context).getTranslated("ok"),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
