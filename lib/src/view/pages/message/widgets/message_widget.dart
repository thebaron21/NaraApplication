import 'package:flutter/material.dart';
import 'package:myapp3/src/logic/config/pallete.dart';
import 'package:myapp3/src/logic/res/res_message_problme.dart';
import 'package:myapp3/src/view/widgets/widget_future.dart';

class WidgetMessage {
  static Widget circle({child, color, size}) {
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

  static Widget circle2({InkWell child, Size size, Color color}) {
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

  static Widget card(Map message, Size size) {
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: kcPrimaryColor.withOpacity(0.4),
      ),
      alignment: Alignment.center,
      child: Center(child: Text(message["message"])),
    );
  }

  static Widget buildMessage(List messages, size) {
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

  static Widget messageFuture(size, superReload) {
    return StreamBuilder(
      stream: ResMessagProblme.getMessage().asStream(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return buildMessage(snapshot.data["data"], size);
        } else if (snapshot.hasError) {
          return WidgetFuture.error(context, superReload);
        } else {
          return WidgetFuture.loading();
        }
      },
    );
  }
}
