import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/core/controller/control.dart';
import 'package:myapp3/views/nara_app.dart';
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
          SuccessPayment obj = SuccessPayment();
          String token = Hive.box(Boxs.NaraApp).get("token");
          await Hive.box(Boxs.CartItem).clear();
          var isDone = await obj.getSuccess(value);
          if (isDone == "success") {
            Getx.of(context).toGetNotBack(NaraApp(token: token));
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
  Dio _dio = Dio();

  getSuccess(String uri) async {
    try {
      var _respnose = await _dio.get(uri);
      print(_respnose.data);
      return _respnose.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
