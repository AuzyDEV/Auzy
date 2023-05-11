import 'package:skeleton/user-profile/profile-model.dart';
import '../../../index.dart';
import '../../../themes/left-drawer.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'all-users-controller.dart';

class usersnewWidget extends StatefulWidget {
  final String speciality;
  const usersnewWidget({Key key, this.speciality}) : super(key: key);

  @override
  _usersnewWidgetState createState() => _usersnewWidgetState();
}

class _usersnewWidgetState extends State<usersnewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<User>> futureUser;
  Future<List<User>> _futureUsers;
  UserMan userServices = UserMan();
  String searchString = "";
  TextEditingController SearchtextController;
  String _futureRoleValue;

  Future<String> _getCurrentUserRole() async {
    return apiUser.GetCurrentUserRole();
  }

  void _getFutureRoleValue() async {
    String value = await _getCurrentUserRole();
    setState(() {
      _futureRoleValue = value;
    });
  }

  Future<void> _refreshList() async {
    setState(() {
      _futureUsers = userServices.getAllUsersNew();
    });
  }

  @override
  void initState() {
    super.initState();
    _getFutureRoleValue();
    _futureUsers = userServices.getAllUsersNew();
    SearchtextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Users'),
      ),
      floatingActionButton: floatingActionButtonWidget(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addUserWidget(),
            ),
          );
        },
        icon: Icons.add,
      ),
      drawer: Drawerr(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0.5, 6.41),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormFieldWidget(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                    hintText: "Search...",
                    controller: SearchtextController,
                  ),
                ],
              ),
            ),
            RefreshIndicator(
                onRefresh: _refreshList,
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: FutureBuilder<List<User>>(
                        future: _futureUsers,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder:
                                    (_, index) =>
                                        ((snapshot.data[index].displayName
                                                    .toLowerCase()
                                                    .contains(searchString)) ||
                                                (snapshot.data[index].email
                                                    .toLowerCase()
                                                    .contains(searchString)))
                                            ? Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 0, 8, 0),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color:
                                                            FlutterAppTheme.of(
                                                                    context)
                                                                .whiteColor,
                                                        elevation: 1,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          8),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                12,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                                                                                  child: Container(
                                                                                    width: 60,
                                                                                    height: 60,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterAppTheme.of(context).primaryColor,
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                                                                      child: ClipRRect(
                                                                                        borderRadius: BorderRadius.circular(60),
                                                                                        child: Image.asset(
                                                                                          "../assets/images/user.png",
                                                                                          width: 50,
                                                                                          height: 50,
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              8,
                                                                              1,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    '${snapshot.data[index].displayName}',
                                                                                    style: FlutterAppTheme.of(context).subtitle1.override(
                                                                                          fontFamily: 'Roboto',
                                                                                          color: FlutterAppTheme.of(context).TextColor,
                                                                                          fontSize: 18,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      '${snapshot.data[index].email}',
                                                                                      style: FlutterAppTheme.of(context).bodyText2.override(
                                                                                            fontFamily: 'Roboto',
                                                                                            color: FlutterAppTheme.of(context).TextColor,
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            10,
                                                                            20,
                                                                            45),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfillWidget(id: snapshot.data[index].id.toString())));
                                                                              },
                                                                              child: Icon(
                                                                                Icons.arrow_forward_ios_outlined,
                                                                                color: FlutterAppTheme.of(context).TextColor,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.85,
                                                                  height: 1,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFDBE2E7),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          8,
                                                                          16,
                                                                          8),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            var confirmDialogResponse = await showDialog<bool>(
                                                                                  context: context,
                                                                                  builder: (alertDialogContext) {
                                                                                    return alertDialogWidget(
                                                                                      title: 'Delete user',
                                                                                      content: 'Are you sure to delete this user ?',
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                          child: Text('Cancel'),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () => {
                                                                                            userServices.deleteUser(snapshot.data[index].id.toString()),
                                                                                            Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) => HomeWidget(),
                                                                                              ),
                                                                                            ),
                                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackbarWidget(
                                                                                                content: Text(
                                                                                              'Successfully User deleted!',
                                                                                            ))),
                                                                                          },
                                                                                          child: Text('Confirm'),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  },
                                                                                ) ??
                                                                                false;
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                40,
                                                                            height:
                                                                                30,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                                                              child: Icon(
                                                                                Icons.delete,
                                                                                color: Color.fromARGB(255, 163, 32, 23),
                                                                                size: 20,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => editprofilWidget(id: snapshot.data[index].id.toString(), name: snapshot.data[index].displayName, email: snapshot.data[index].email, photourl: snapshot.data[index].photoURL.toString()),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                40,
                                                                            height:
                                                                                30,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                                                              child: Icon(
                                                                                Icons.update,
                                                                                color: Color.fromARGB(255, 214, 116, 36),
                                                                                size: 20,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      snapshot.data[index].disabled.toString() ==
                                                                              "false"
                                                                          ? Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                              child: InkWell(
                                                                                onTap: () async {
                                                                                  var confirmDialogResponse = await showDialog<bool>(
                                                                                        context: context,
                                                                                        builder: (alertDialogContext) {
                                                                                          return alertDialogWidget(
                                                                                            title: 'block user',
                                                                                            content: 'Are you sure to block this user ?',
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                child: Text('Cancel'),
                                                                                              ),
                                                                                              TextButton(
                                                                                                onPressed: () => {
                                                                                                  userServices.BlockUser(snapshot.data[index].id.toString()),
                                                                                                  Navigator.push(
                                                                                                    context,
                                                                                                    MaterialPageRoute(
                                                                                                      builder: (context) => usersnewWidget(),
                                                                                                    ),
                                                                                                  ),
                                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                                    SnackbarWidget(
                                                                                                      content: Text('Successfully User blocked!'),
                                                                                                    ),
                                                                                                  ),
                                                                                                },
                                                                                                child: Text('Confirm'),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      ) ??
                                                                                      false;
                                                                                },
                                                                                child: Container(
                                                                                  width: 40,
                                                                                  height: 30,
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                                                                    child: Icon(
                                                                                      Icons.block,
                                                                                      color: Colors.red,
                                                                                      size: 20,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                              child: InkWell(
                                                                                onTap: () async {
                                                                                  var confirmDialogResponse = await showDialog<bool>(
                                                                                        context: context,
                                                                                        builder: (alertDialogContext) {
                                                                                          return alertDialogWidget(
                                                                                            title: 'restore user',
                                                                                            content: 'Are you sure to restore this user ?',
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                child: Text('Cancel'),
                                                                                              ),
                                                                                              TextButton(
                                                                                                onPressed: () => {
                                                                                                  userServices.RestoreUser(snapshot.data[index].id.toString()),
                                                                                                  Navigator.push(
                                                                                                    context,
                                                                                                    MaterialPageRoute(
                                                                                                      builder: (context) => usersnewWidget(),
                                                                                                    ),
                                                                                                  ),
                                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackbarWidget(
                                                                                                    content: Text(
                                                                                                      'Successfully User restored!',
                                                                                                    ),
                                                                                                  )),
                                                                                                },
                                                                                                child: Text('Confirm'),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      ) ??
                                                                                      false;
                                                                                },
                                                                                child: Container(
                                                                                  width: 40,
                                                                                  height: 30,
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                                                                    child: Icon(
                                                                                      Icons.repeat_rounded,
                                                                                      color: Colors.green,
                                                                                      size: 20,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container());
                          } else if (snapshot.hasError) {
                            return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                                child: Text('No doctors',
                                    textAlign: TextAlign.center,
                                    style: FlutterAppTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Roboto',
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        )));
                          }
                          return const CircularProgressIndicator(
                            color: Color(0xFF9457FB),
                          );
                        }))),
          ],
        ),
      ),
    );
  }
}
