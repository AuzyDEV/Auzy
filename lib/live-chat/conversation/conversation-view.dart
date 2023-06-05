import 'package:flutter/material.dart';
import '../../index.dart';
import '../../user-profile/profile-controller.dart';
import '../../user-profile/profile-model.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({@required this.user,Key key,}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ProfilingMan profilingUserServices = ProfilingMan();
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    _futureUser = profilingUserServices.GetCurrentUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
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
            return const CircularProgressIndicatorWidget();
          }
        )
    ),
  );
}
