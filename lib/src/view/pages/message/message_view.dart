import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:myapp3/src/logic/config/LocaleLang.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/res/res_message_problme.dart';

import 'widgets/message_widget.dart';

class ChatWithUsView extends StatefulWidget {
  const ChatWithUsView({Key key}) : super(key: key);

  @override
  _ChatWithUsViewState createState() => _ChatWithUsViewState();
}

class _ChatWithUsViewState extends State<ChatWithUsView> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var t = AppLocale.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //t.getTranslated("chat_with_us"),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Message", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          WidgetMessage.circle2(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.remove),
            ),
            size: size,
            color: Color(0xFF333333),
          ),
          SizedBox(width: 10)
        ],
        leadingWidth: size.width * 0.3,
        leading: FlatButton(
          child: Text(
            "End Chat",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: WidgetMessage.messageFuture(size, () => setState(() {})),
      ),
      bottomSheet: _chat(size),
    );
  }

  bool isLoading = false;
  _chat(size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.7,
            height: 40,
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Type a  Message ...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 0.8
                      ..color = Colors.black),
              ),
            ),
          ),
          isLoading == false
              ? InkWell(
                  onTap: onTap,
                  child: WidgetMessage.circle(
                    child: Icon(
                      IconMoon.icon_telegram1,
                      color: Colors.white,
                      size: 17,
                    ),
                    color: kcPrimaryColor,
                    size: size,
                  ),
                )
              : WidgetMessage.circle(
                  child: Center(child: CircularProgressIndicator()),
                  color: kcPrimaryColor,
                  size: size,
                ),
        ],
      ),
    );
  }

  void onTap() async {
    setState(() => isLoading = true);
    var data = await ResMessagProblme.setMessage(
        toId: "1", message: messageController.text);
    messageController.clear();
    setState(() => isLoading = false);
  }
}
