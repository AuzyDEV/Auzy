import 'package:lottie/lottie.dart';
import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/apis/sharedPostMan.dart';
import 'package:new_mee/chat/chat_page.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/components/chat_body_widget.dart';
import 'package:new_mee/components/chat_header_widget.dart';
import 'package:new_mee/components/drawer.dart';
import 'package:new_mee/components/theme.dart';
import 'package:new_mee/components/widgets.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class UsersListForPostsWidget extends StatefulWidget {
  final String postId, postImage, CurrentuserId, adminName, adminPhoto;
  final Postcontenu;
  const UsersListForPostsWidget(
      {Key key,
      this.postId,
      this.Postcontenu,
      this.postImage,
      this.CurrentuserId,
      this.adminName,
      this.adminPhoto})
      : super(key: key);

  @override
  _UsersListForPostsWidgetState createState() =>
      _UsersListForPostsWidgetState();
}

class _UsersListForPostsWidgetState extends State<UsersListForPostsWidget> {
  String searchString = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController;
  Future<List<User>> futurePost;
  String value, value1;
  UserMan api = UserMan();
  int selectedCard1 = -1;
  String idSharedUser;
  Future<User> _futureUser;
  sharedPostMan sharedpostapi = sharedPostMan();
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _futureUser = api.GetCurrentUser();
    futurePost = api.getAllUsersRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Messages'),
      ),
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: FutureBuilder<User>(
                    future: _futureUser,
                    builder: (context, snapshot1) {
                      if (snapshot1.hasData) {
                        return SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 15, 0, 0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 52,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15, 0, 15, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.search,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 24,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 2),
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
                                                      hintText:
                                                          'Search users ...',
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xFF57636C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                                child:
                                                    FutureBuilder<List<User>>(
                                                  future: futurePost,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      final users =
                                                          snapshot.data;
                                                      return ListView.separated(
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .data.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                index) {
                                                          return ((snapshot
                                                                  .data[index]
                                                                  .displayName
                                                                  .toLowerCase()
                                                                  .contains(
                                                                      searchString)))
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedCard1 =
                                                                          index;
                                                                      idSharedUser =
                                                                          users[index]
                                                                              .id;
                                                                    });
                                                                  },
                                                                  child: Card(
                                                                      clipBehavior:
                                                                          Clip
                                                                              .antiAliasWithSaveLayer,
                                                                      color: selectedCard1 == index
                                                                          ? Colors.red[
                                                                              200]
                                                                          : Colors
                                                                              .white,
                                                                      elevation:
                                                                          1,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child: Container(
                                                                          color: selectedCard1 == index ? Colors.red[200] : Colors.white,
                                                                          height: 60,
                                                                          child: Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                5,
                                                                                0,
                                                                                5),
                                                                            child:
                                                                                ListTile(
                                                                              leading: CircleAvatar(
                                                                                radius: 25,
                                                                                backgroundImage: NetworkImage(users[index].photoURL),
                                                                              ),
                                                                              title: Text(users[index].displayName),
                                                                            ),
                                                                          ))))
                                                              : Container();
                                                        },
                                                        separatorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return snapshot
                                                                  .data[index]
                                                                  .displayName
                                                                  .toLowerCase()
                                                                  .contains(
                                                                      searchString)
                                                              ? Container()
                                                              : Container();
                                                        },
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text("no users!");
                                                    }
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                          child:
                                                              const CircularProgressIndicator(),
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
                                      Row(children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 16, 0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                
                                                bool response =
                                                    await sharedpostapi
                                                        .SharePost(
                                                            widget.postId,
                                                            widget.Postcontenu,
                                                            widget.postImage,
                                                            widget.adminName,
                                                            widget.adminPhoto,
                                                            widget
                                                                .CurrentuserId,
                                                            snapshot1.data
                                                                .displayName,
                                                            snapshot1
                                                                .data.photoURL,
                                                            idSharedUser);
                                                response == true
                                                    ? showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text("Succes!"),
                                                            content: Text(
                                                                "post shared!"),
                                                            actions: [
                                                              FlatButton(
                                                                child:
                                                                    Text("ok"),
                                                                onPressed:
                                                                    () async {
                                                                  await Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              postsForUsersWidget(),
                                                                    ),
                                                                  );
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        })
                                                    : showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text("Error"),
                                                            content: Text(
                                                                "You have already share this post with this user"),
                                                            actions: [
                                                              FlatButton(
                                                                child:
                                                                    Text("Ok"),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        });
                                              },
                                              text: 'share',
                                              options: FFButtonOptions(
                                                height: 45,
                                                color: Color(0xff132137),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBtnText,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot1.hasError) {
                        return Text("${snapshot1.error}");
                      }

                      // By default, show a loading spinner.
                      return Center(child: const CircularProgressIndicator());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
