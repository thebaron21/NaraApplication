import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/function/router_function.dart';
import 'package:myapp3/src/logic/res/res_message_problme.dart';
import 'package:myapp3/src/view/app_nara.dart';
import 'package:myapp3/src/view/pages/message/problem_widget.dart';
import 'package:myapp3/src/view/widgets/widget_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'message_view.dart';

class CallUsView extends StatefulWidget {
  const CallUsView({Key key}) : super(key: key);

  @override
  _CallUsViewState createState() => _CallUsViewState();
}

class _CallUsViewState extends State<CallUsView> {
  @override
  Widget build(BuildContext context) {
    var t = AppLocale.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        context: context,
        title: t.getTranslated("call_us"),
      ),
      body: SingleChildScrollView(
        child: WidgetProblme.contentChat(
          size,
          name: name,
          email: email,
          phone: phone,
          commit: commit,
          context: context,
          onTap: onTap,
        ),
      ),
      bottomSheet: Container(
        height: 100,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: WidgetProblme.btnSend(size, onTap),
        ),
      ),
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController commit = TextEditingController();

  void onTap() async {
    setState(() => WidgetProblme.isLoading = true);
    var data = await ResMessagProblme.setProblme(
      username: name.text,
      email: email.text,
      mobile: phone.text,
      content: commit.text,
    );
    if (data["statusCode"] == 200) {
      RouterF.of(context).push(() => AppNara());
    }
    setState(() => WidgetProblme.isLoading = false);
  }
}
