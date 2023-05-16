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
    futurePost = userServices.GetAllUsersForChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Users'),
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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 15, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: FlutterAppTheme.of(context)
                                          .tertiaryColor,
                                      size: 24,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 2),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              searchString =
                                                  value.toLowerCase();
                                            });
                                          },
                                          controller: textController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Search users ...',
                                            hintStyle:
                                                FlutterAppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      color: Colors.grey,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterAppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Roboto',
                                                color: Color(0xFF57636C),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: FutureBuilder<List<User>>(
                                        future: futurePost,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final users = snapshot.data;
                                            return ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: snapshot.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return ((snapshot
                                                        .data[index].displayName
                                                        .toLowerCase()
                                                        .contains(
                                                            searchString)))
                                                    ? Container(
                                                        height: 75,
                                                        child: ListTile(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChatPage(
                                                                      user: users[
                                                                          index]),
                                                            ));
                                                          },
                                                          leading: CircleAvatar(
                                                            radius: 25,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    "../assets/images/user.png"),
                                                          ),
                                                          title: Text(
                                                              users[index]
                                                                  .displayName),
                                                        ),
                                                      )
                                                    : Container();
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return snapshot
                                                        .data[index].displayName
                                                        .toLowerCase()
                                                        .contains(searchString)
                                                    ? Container()
                                                    : Container();
                                              },
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text("no users!");
                                          }
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child:
                                                    const CircularProgressIndicatorWidget(),
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
