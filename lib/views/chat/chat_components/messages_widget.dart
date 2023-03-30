import 'dart:async';
import 'package:flutter/material.dart';
import '../../../services/messagesMan.dart';
import 'message_widget.dart';
import '../../../models/Message.dart';

class MessagesWidget extends StatefulWidget {
  final String idUser, myId;

  const MessagesWidget({
    @required this.idUser,
    this.myId,
    Key key,
  }) : super(key: key);
  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  Timer _timer;
  int start = 0;
  StreamController streamController;
  ValueNotifier<String> _myString = ValueNotifier<String>('');
  Stream<List<Message>> list;
  int nbr;
  @override
  void initState() {
    super.initState();
    //startTimer();
    //getnbr();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: MessageMan.getMessages(widget.idUser),
        builder: (context, snapshot) {
          // int length = snapshot.data.length;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;
                /*  streamController.stream.listen((data) {
                  print("listen value- $data");
                });*/
                return messages.isEmpty
                    ? buildText('Say Hi..')
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

  /*Widget build(BuildContext context) => FutureBuilder<List<Message>>(
      future: FirebaseApi.getAllMessages(idUser),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data;

          return messages.isEmpty
              ? buildText('Say Hi..')
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    print(this.myId);
                    final message = messages[index];

                    return MessageWidget(
                      message: message,
                      isMe: message.idUser == this.myId,
                    );
                  },
                  
                );
                
        } else {
          print(snapshot.error);
        }
        
        return Center(child: CircularProgressIndicator());
        
      });*/

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
