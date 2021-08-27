
import 'package:flutter/material.dart';
import 'package:myapp3/config/pallete.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget leading;
  final Widget trailing;
  final bool password;
  final void Function() trailingTapped;

  const CustomTextField(
      {Key key,
      this.controller,
      this.placeholder,
      this.leading,
      this.trailing,
      this.password,
      this.trailingTapped})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final circularBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    );
    return Container(
      height: size.height * 0.07,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(4),
      //     color: Colors.white,
      //   ),
      //   alignment: Alignment.center,
      //   child: Center(
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.password,
        decoration: InputDecoration(
          filled: true,
          fillColor: kcVeryLightGreyColor,
          hintText: widget.placeholder,
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
        // ),
      ),
    );
  }
}
