import 'package:flutter/material.dart';
import 'package:myapp3/config/pallete.dart';

class BoxButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function() onTap;
  final bool outline;
  final Widget leading;
  final bool isBig;

  const BoxButton({
    @required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.leading,
    this.isBig,
  })  : outline = false,
        super();

  const BoxButton.outline({
    @required this.title,
    this.onTap,
    this.leading, this.isBig,
  })  : disabled = false,
        busy = false,
        outline = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: busy == true ? 130 : size.width,
        height: 48,
        alignment: Alignment.center,
        decoration: !outline
            ? BoxDecoration(
                color: !disabled ? kcPrimaryColor : kcMediumGreyColor,
                borderRadius: BorderRadius.circular(4),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: kcPrimaryColor,
                  width: 1,
                )),
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading,
                  if (leading != null) SizedBox(width: 5),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: !outline ? FontWeight.bold : FontWeight.w400,
                      color: !outline ? Colors.white : kcPrimaryColor,
                      fontSize: 17,
                    ),
                  ),
                ],
              )
            : CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}
