import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page()));
  }
}
