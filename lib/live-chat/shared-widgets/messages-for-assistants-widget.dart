import 'dart:async';
import 'package:flutter/material.dart';
import '../../index.dart';
import '../../user-profile/profile-controller.dart';
import '../conversation/conversation-controller.dart';
import '../conversation/conversation-model.dart';

class MessagesForAssistantsWidget extends StatefulWidget {
  final String idUser, myId;
  

  const MessagesForAssistantsWidget({@required this.idUser, this.myId,  Key key, }) : super(key: key);
  @override
  _MessagesForAssistantsWidgetState createState() => _MessagesForAssistantsWidgetState();
}

class _MessagesForAssistantsWidgetState extends State<MessagesForAssistantsWidget> {
  int start = 0;
  StreamController streamController;
  Stream<List<Message>> list;
  int nbr;
  ProfilingMan profilingUserServices = ProfilingMan();
  String _CurrentUserId;

  Future<String> _getCurrentUserId() async {
    return profilingUserServices.GetIDCurrentUser();
  }

  void _getFutureStringValue() async {
    String value = await _getCurrentUserId();
    setState(() {
      _CurrentUserId = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFutureStringValue();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
    stream: MessageMan.getMessages(_CurrentUserId, widget.idUser),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicatorWidget());
        default:
          if (snapshot.hasError) {
            return buildText('Something Went Wrong Try later');
          } else {
            final messages = snapshot.data;
            return messages.isEmpty
            ? buildText('Say Hi.. 👋')
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return MessageWidget(
                    message: message,
                    isMe: message.idUser == widget.myId,
                  );
                },
              );
          }
      }
    },
  );
  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
  );
}
