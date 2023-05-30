import '../../admin-functions/user-management/all-users/all-users-controller.dart';
import '../../index.dart';
import '../../../themes/theme.dart';
import '../../user-profile/profile-model.dart';
import 'package:flutter/material.dart';

class chatcopyWidget extends StatefulWidget {
  const chatcopyWidget({Key key}) : super(key: key);

  @override
  _chatcopyWidgetState createState() => _chatcopyWidgetState();
}

class _chatcopyWidgetState extends State<chatcopyWidget> {
  String searchString = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController;
  Future<List<User>> futurePost;
  String value, value1;
  UserMan userServices = UserMan();
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    futurePost = userServices.GetAllAssistants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Live Assistant'),
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
                                        future: futurePost,
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
                                                            ChatPage( user: users[index]),
                                                        )
                                                      );
                                                    },
                                                    leading: Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage:
                                                        NetworkImage(users[index].photoURL),
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
                                                  title: Text(users[index].displayName),
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
