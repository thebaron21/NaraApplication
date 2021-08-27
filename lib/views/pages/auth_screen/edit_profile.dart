import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/bloc/rxdartBloc/auth_rxdart_bloc.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/core/model/user_model.dart';

import 'change_password.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile user;
  const EditProfilePage({Key key, this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  /// [Hit] Text

  /// [Controller] Text Get [Data]
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  /// [Logic] of Page
  @override
  void initState() {
    super.initState();
    username.text = widget.user.name;
    email.text = widget.user.email;
    phone.text = widget.user.mobile;
  }

  /// one [Widget]
  get _designAndTextField =>
      (Size size, TextEditingController controller, String hit) => Container(
            width: size.width,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller,
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

  get _btn => (String text, Size size, Function onTap) => Center(
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
              text,
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
          _designAndTextField(
              size, username, AppLocale.of(context).getTranslated("username")),
          line,
          _designAndTextField(
            size,
            email,
            AppLocale.of(context).getTranslated("email"),
          ),
          line,
          _designAndTextField(
            size,
            phone,
            AppLocale.of(context).getTranslated("phoneNumber"),
          ),
          line,
          _sizeBetweenText(size),
          _btn(
            AppLocale.of(context).getTranslated("edit"),
            size,
            () async {
              print("Loading ...");
              var isEdit = await authRxdartBloc.editProfile(
                name: username.text,
                email: email.text,
                phone: phone.text,
              );
              print("Awating idEdit ... $isEdit");
              // print(i)
              if (isEdit == true) {
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
              }
              setState(() => isLoading = false);
              print("End Loading ...");
            },
          ),
          _sizeBetweenText(size),
          _btn(AppLocale.of(context).getTranslated("change_password"), size,
              () {
            Getx.of(context).toGet(ChangePasswordPage());
          }),
          _sizeBetweenText(size)
        ],
      ),
    );
  }

  /// Help [Size] All Page
  get _sizeBetween => (Size size) => SizedBox(height: size.height * 0.05);
  get _sizeBetweenText => (Size size) => SizedBox(height: size.height * 0.025);
}
