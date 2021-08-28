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
}
