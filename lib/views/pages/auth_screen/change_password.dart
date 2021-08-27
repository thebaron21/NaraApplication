import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/auth_rxdart_bloc.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  

  /// [Controller] Text Get [Data]
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirmation = TextEditingController();

  /// one [Widget]
  get _designAndTextField =>
      (Size size, TextEditingController controller, bool isShow, String hit) =>
          Container(
            width: size.width,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller,
              obscureText: isShow,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: hit,
                border: InputBorder.none,
              ),
            ),
          );

  Widget get line => Divider(
        thickness: 0.5,
        height: 1,
        color: Colors.black.withOpacity(0.4),
      );

  get _btnSave => (Size size, Function onTap) => Center(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: size.width * 0.95,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: kcPrimaryColor,
            ),
            alignment: Alignment.center,
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocale.of(context).getTranslated("change_password"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _designAndTextField(
            size,
            oldPassword,
            false,
            AppLocale.of(context).getTranslated("old_password"),
          ),
          line,
          _designAndTextField(
            size,
            newPassword,
            false,
            AppLocale.of(context).getTranslated("new_password"),
          ),
          line,
          _designAndTextField(
            size,
            newPasswordConfirmation,
            false,
            AppLocale.of(context).getTranslated("new_password_confirmation"),
          ),
          line,
          _sizeBetweenText(size),
          isLoading == false
              ? _btnSave(
                  size,
                  () async {
                    setState(() => isLoading = true);
                    await authRxdartBloc.editPassword(
                      oldPass: oldPassword.text,
                      pass: newPassword.text,
                      confirmPass: newPasswordConfirmation.text,
                    );
                    authRxdartBloc.subjectPassword.stream.listen((event) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              AppLocale.of(context).getTranslated("success"),
                            ),
                            content: Text( 
                              AppLocale.of(context).getTranslated("done"),
                            ),
                            actions: [
                              // ignore: deprecated_member_use
                              FlatButton(
                                onPressed: () {
                                  authRxdartBloc.close();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  AppLocale.of(context).getTranslated("okey"),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    });

                    setState(() => isLoading = false);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: kcPrimaryColor,
                  ),
                ),
        ],
      ),
    );
  }

  /// Help [Size] All Page
  get _sizeBetween => (Size size) => SizedBox(height: size.height * 0.05);
  get _sizeBetweenText => (Size size) => SizedBox(height: size.height * 0.025);
}
