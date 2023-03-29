import 'package:flutter/material.dart';
import 'package:new_mee/services/User_api.dart';
import 'package:new_mee/models/User.dart';
import 'chat_components/chat_body_widget.dart';
import 'chat_components/chat_header_widget.dart';

class ChatsPage extends StatelessWidget {
  UserMan api = UserMan();
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: FutureBuilder<List<User>>(
              future: api.GetAllUsersForChats(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final users = snapshot.data;
                  print(users);
                  if (users.isEmpty) {
                    return buildText('No Users Found');
                  } else
                    return Column(
                      children: [
                        ChatHeaderWidget(users: users),
                        ChatBodyWidget(users: users)
                      ],
                    );
                } else {
                  print(snapshot.error);
                }
                return const CircularProgressIndicator();
              }),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
