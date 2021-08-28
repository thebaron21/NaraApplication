import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_auth.dart';

import 'widgets/box_button.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BoxButton(
              busy: isLoading,
              disabled: isLoading,
              title: "حفظ",
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }

  onTap() async {
    if (newPassword.text == newPasswordConfirmation.text) {
      setState(() => isLoading = true);
      var data = await ResAuth.editP(
        newPass: newPassword.text,
        oldPass: oldPassword.text,
      );
      if (data is DioError) {
        if (data.response.statusCode == 406) {
          RouterF.of(context).message("خطأ", data.response.data["error"]);
        }
      }
      setState(() => isLoading = false);
    } else {
      RouterF.of(context).message("خطأ", "كلمة السر غير متطابقة");
    }
  }

  /// Help [Size] All Page
  get _sizeBetween => (Size size) => SizedBox(height: size.height * 0.05);
  get _sizeBetweenText => (Size size) => SizedBox(height: size.height * 0.025);
}
