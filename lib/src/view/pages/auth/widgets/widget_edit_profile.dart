import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/pallete.dart';

class WidgetEditProfile {
  /// Help [Size] All Page
  static sizeBetween(Size size) => SizedBox(height: size.height * 0.05);
  static sizeBetweenText(Size size) => SizedBox(height: size.height * 0.025);

  /// one [Widget]
  static Widget designAndTextField(
          Size size, TextEditingController controller, String hit) =>
      Container(
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

  static Widget line() => Divider(
        thickness: 0.5,
        height: 1,
        color: Colors.black.withOpacity(0.4),
      );

  static btn(bool isLoading, String text, Size size, Function onTap) {
    return Center(
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
          child: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: kcPrimaryColor,
                  ),
                )
              : Text(
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
  }
}
