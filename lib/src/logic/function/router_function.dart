import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';

class RouterF {
  final BuildContext context;

  RouterF(this.context);

  factory RouterF.of(context) {
    return RouterF(context);
  }

  push(Function page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page()));
  }

  put(Function page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page()));
  }

  message(title, content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
              child: Text(AppLocale.of(this.context).getTranslated("ok")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
