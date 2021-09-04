import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/view/app_nara.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({this.url});
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,        
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String value) async {
          await Hive.box(Boxs.CartItem).clear();
          var isDone = await SuccessPayment.getSuccess(value);
          if (isDone == "success") {
            RouterF.of(context).put(() => AppNara());
          }
          print("onPageFinished: $value");
        },
        onPageStarted: (String value) {
          print("onPageStarted: $value");
        },
      ),
    );
  }
}

class SuccessPayment {
  static Dio _dio = Dio();

  static getSuccess(String uri) async {
    try {
      var _respnose = await _dio.get(uri);
      print(_respnose.data);
      return _respnose.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
