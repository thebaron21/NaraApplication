import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp3/config/LocaleLang.dart';

class Getx {
  final BuildContext context;
  Getx({this.context});

  // ignore: missing_return
  factory Getx.of(context) {
    return Getx(context: context);
  }
  void printIntegers(void Function(String msg) logger) {
    logger("Done.");
  }

  toGet(nameClass) {
    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return nameClass;
    }));
  }

  toGetNotBack(nameClass) {
    Navigator.pushReplacement(this.context,
        MaterialPageRoute(builder: (context) {
      return nameClass;
    }));
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
            ]);
      },
    );
  }
}
