import 'package:flutter/material.dart';
import '../../index.dart';
import '../../themes/theme.dart';
import '../conversation/conversation-model.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({
    @required this.message,
    @required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isMe)
          InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfillWidget(id: message.idUser),
                ),
              );
            },
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("../../assets/images/user.png")
            ),
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              constraints: BoxConstraints(maxWidth: 170),
              decoration: BoxDecoration(
                color: isMe ? FlutterAppTheme.of(context).lightGrey : Colors.blue,
                borderRadius: isMe
                  ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                  : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
              ),
              child: buildMessage(),
            ),
          ],
        )
      ],
    );
  }

  Widget buildMessage() => Column(
    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        message.message,
        style: TextStyle(color: isMe ? Colors.black : Colors.white),
        textAlign: isMe ? TextAlign.end : TextAlign.start,
      ),
    ],
  );
}
