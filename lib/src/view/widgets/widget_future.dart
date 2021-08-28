import 'package:flutter/material.dart';
import '../../logic/config/pallete.dart';

class WidgetFuture {
  static Widget loading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: kcPrimaryColor,
      ),
    );
  }

  static Widget error(BuildContext context, Function superReload) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.replay_sharp, color: kcPrimaryColor),
        onPressed: () {
          superReload();
        },
      ),
    );
  }

 static  Widget row(
    {@required String text,
    @required String viewAll,
    @required Function onTap}) {
  return Row(
    children: [
      SizedBox(
        width: 10,
      ),
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(height: 0.5, color: Colors.black.withOpacity(0.8)),
      ),
      SizedBox(
        width: 1,
      ),
      // ignore: deprecated_member_use
      FlatButton(
        onPressed: onTap,
        child: Text(viewAll),
      ),
    ],
  );
}
}
