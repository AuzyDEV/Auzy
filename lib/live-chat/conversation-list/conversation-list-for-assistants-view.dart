import '../../index.dart';
import '../../user-profile/profile-controller.dart';
import '../../user-profile/profile-model.dart';
import 'package:flutter/material.dart';
import '../conversation/conversation-controller.dart';
import '../conversation/conversation-for-assistants-view.dart';

class ConversationListUsersForAssistantWidget extends StatefulWidget {
  const ConversationListUsersForAssistantWidget({Key key}) : super(key: key);

  @override
  _ConversationListUsersForAssistantWidgetState createState() => _ConversationListUsersForAssistantWidgetState();
}

class _ConversationListUsersForAssistantWidgetState extends State<ConversationListUsersForAssistantWidget> {
  String searchString = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController;
  Future<List<User>> futurePost;
  String value, value1;
  MessageMan MessageServices = MessageMan();
  String _CurrentUserId;
  ProfilingMan profilingUserServices = ProfilingMan();

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
    textController = TextEditingController();
    _getFutureStringValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Assistant\'s Chat'),
      ),
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      child: FutureBuilder<List<User>>(
                                        future: MessageServices.getAllUsersBySpecifiedAssistant(_CurrentUserId),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final users = snapshot.data;
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (BuildContext context, index) {
                                                return Container(
                                                  height: 75,
                                                  child: ListTile(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                            ChatPageForAssistant( user: users[index]),
                                                        )
                                                      );
                                                    },
                                                    leading: Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage: AssetImage("../../assets/images/user.png"),
                                                        ),
                                                        Positioned(
                                                          top: 35,
                                                          right: 0,
                                                          child: Container(
                                                            width: 10,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.green, 
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    title: Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(users[index].displayName),
                                                          Padding(
                                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Text(
                                                              "Online",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors.green,
                                                              ),
                                                            )
                                                          )
                                                        ],
                                                      )
                                                    )
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text("no users!");
                                          }
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: const CircularProgressIndicatorWidget(),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
