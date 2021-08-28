import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_auth.dart';

import 'change_password.dart';
import 'profile_page.dart';
import 'widgets/box_button.dart';
import 'widgets/widget_edit_profile.dart';

class EidtProfileView extends StatefulWidget {
  final Map user;
  const EidtProfileView({Key key, this.user}) : super(key: key);

  @override
  _EidtProfileViewState createState() => _EidtProfileViewState();
}

class _EidtProfileViewState extends State<EidtProfileView> {
  /// [Hit] Text

  /// [Controller] Text Get [Data]
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  /// [Logic] of Page
  @override
  void initState() {
    super.initState();
    username.text = widget.user["name"];
    email.text = widget.user["email"];
    phone.text = widget.user["mobile"];
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppLocale.of(context).getTranslated("info_account"),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          WidgetEditProfile.designAndTextField(
            size,
            username,
            AppLocale.of(context).getTranslated("username"),
          ),
          WidgetEditProfile.line(),
          WidgetEditProfile.designAndTextField(
            size,
            email,
            AppLocale.of(context).getTranslated("email"),
          ),
          WidgetEditProfile.line(),
          WidgetEditProfile.designAndTextField(
            size,
            phone,
            AppLocale.of(context).getTranslated("phoneNumber"),
          ),
          WidgetEditProfile.line(),
          WidgetEditProfile.sizeBetweenText(size),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BoxButton(
              busy: isLoading,
              title: AppLocale.of(context).getTranslated("edit"),
              onTap: edit,
            ),
          ),
          WidgetEditProfile.sizeBetweenText(size),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BoxButton(
              busy: isLoading,
              title: AppLocale.of(context).getTranslated("change_password"),
              onTap: changePassword,
            ),
          ),
          WidgetEditProfile.sizeBetweenText(size)
        ],
      ),
    );
  }

  edit() async {
    setState(() => isLoading = true);
    var data = await ResAuth.edit(
      email: email.text,
      mobile: phone.text,
      name: username.text,
    );
    RouterF.of(context).push(() => ProfileView());
    setState(() => isLoading = false);
  }

  void changePassword() {
    RouterF.of(context).push( () => ChangePasswordView());
  }
}
