import 'package:flutter/material.dart';
import 'package:myapp3/config/pallete.dart';

class BoxInputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget leading;
  final Widget trailing;
  final bool password;
  final void Function() trailingTapped;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(3),
  );

  BoxInputField({
    @required this.controller,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.password = false,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: password,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.ltr,
        hintStyle: TextStyle(
          textBaseline: TextBaseline.ideographic,
        ),
        hintText: placeholder,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: leading,
        suffixIcon: trailing != null
            ? GestureDetector(
                onTap: trailingTapped,
                child: trailing,
              )
            : null,
        border: circularBorder.copyWith(
          borderSide: BorderSide(color: kcLightGreyColor),
        ),
        errorBorder: circularBorder.copyWith(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: circularBorder.copyWith(
          borderSide: BorderSide(color: kcPrimaryColor),
        ),
        enabledBorder: circularBorder.copyWith(
          borderSide: BorderSide(color: kcLightGreyColor),
        ),
      ),
    );
  }
}
