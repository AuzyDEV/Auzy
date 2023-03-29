import 'package:flutter/material.dart';
import 'package:new_mee/services/User_api.dart';
import 'package:new_mee/views/chat/chat_components/messages_widget.dart';
import 'package:new_mee/views/chat/chat_components/new_message_widget.dart';
import 'package:new_mee/views/chat/chat_components/profile_header_widget.dart';
import 'package:new_mee/models/User.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  UserMan api = UserMan();
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    _futureUser = api.GetCurrentUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xff132137),
        body: SafeArea(
            child: FutureBuilder<User>(
                future: _futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ProfileHeaderWidget(name: widget.user.displayName),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: MessagesWidget(
                                idUser: widget.user.id, myId: snapshot.data.id),
                          ),
                        ),
                        NewMessageWidget(idUser: widget.user.id)
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                })),
      );
}
