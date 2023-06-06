import 'package:flutter/material.dart';
import '../../index.dart';
import '../../user-profile/profile-controller.dart';
import '../../user-profile/profile-model.dart';
import '../shared-widgets/messages-for-assistants-widget.dart';
import '../shared-widgets/new-message-for-assistant-widget.dart';

class ChatPageForAssistant extends StatefulWidget {
  final User user;

  const ChatPageForAssistant({@required this.user,Key key,}) : super(key: key);

  @override
  _ChatPageForAssistantState createState() => _ChatPageForAssistantState();
}

class _ChatPageForAssistantState extends State<ChatPageForAssistant> {
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
                      child: MessagesForAssistantsWidget(
                          idUser: widget.user.id, myId: snapshot.data.id),
                    ),
                  ),
                  NewMessageForAssistantWidget(idUser: widget.user.id)
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
