import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp3/config/LocaleLang.dart';
import 'package:myapp3/config/boxs.dart';
import 'package:myapp3/config/pallete.dart';
import 'package:myapp3/core/model/message_model.dart';
import 'package:myapp3/core/repoitorites/message_repository.dart';
import 'package:myapp3/core/response/message_response.dart';

class HomeStram {
  StreamController<MessageRepository> _stream =
      StreamController<MessageRepository>.broadcast();

  MessageResponse _response = MessageResponse();
  HomeStram() {
    init();
  }
  close() {
    _stream.close();
  }

  void init() async {
    var value = await _response.getMessages();
    print(value.messages);
    _stream.sink.add(value);
  }
}

class ChatWithUsPage extends StatefulWidget {
  const ChatWithUsPage({Key key}) : super(key: key);

  @override
  _ChatWithUsPageState createState() => _ChatWithUsPageState();
}

class _ChatWithUsPageState extends State<ChatWithUsPage> {
  MessageResponse _response = MessageResponse();
  TextEditingController messageController = TextEditingController();
  HomeStram _homeStram = HomeStram();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _homeStram.close();
  }

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
          _circle2(
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: FutureBuilder<MessageRepository>(
              future: _response.getMessages(),
              builder: (context, AsyncSnapshot<MessageRepository> d) {
                if (d.hasData) {
                  if (d.data.error == null && d.data.messages.length > 0) {
                    return _buildMessage(d.data.messages, size);
                  } else {
                    return _buildError(d.data.error);
                  }
                } else if (d.hasError) {
                  return _buildError(d.data.error);
                } else {
                  return _buildLoading();
                }
              },
            ),
          )),
      bottomSheet: _chat(size),
    );
  }

  _buildMessage(List<MessageModel> messages, size) {
    return Column(
      children: [
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return card(messages[index], size);
          },
        ),
        SizedBox(
          height: size.height * 0.1,
        )
      ],
    );
  }

  card(MessageModel message, Size size) {
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: kcPrimaryColor.withOpacity(0.4),
      ),
      alignment: Alignment.center,
      child: Center(child: Text(message.message)),
    );
  }

  _buildError(s) {
    return Center(
      child: Text(
        s.toString(),
      ),
    );
  }

  _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: kcPrimaryColor,
      ),
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
                  onTap: () async {
                    String token = Hive.box(Boxs.NaraApp).get("token");
                    if (token != null) {
                      setState(() => isLoading = true);
                      var data = await _response.setMessage(
                        MessageModel(
                          toId: "1",
                          message: messageController.text,
                        ),
                      );
                      setState(() => isLoading = false);
                    } else {
                      setState(() => isLoading = false);
                    }
                  },
                  child: _circle(
                    child: Icon(
                      IconMoon.icon_telegram1,
                      color: Colors.white,
                      size: 17,
                    ),
                    color: kcPrimaryColor,
                    size: size,
                  ),
                )
              : _circle(
                  child: Center(child: CircularProgressIndicator()),
                  color: kcPrimaryColor,
                  size: size,
                ),
        ],
      ),
    );
  }

  _circle({child, color, size}) {
    return Container(
      width: size.width * 0.1,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      alignment: Alignment.center,
      child: Center(child: child),
    );
  }

  _circle2({InkWell child, Size size, Color color}) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      alignment: Alignment.center,
      child: Center(child: child),
    );
  }
}
