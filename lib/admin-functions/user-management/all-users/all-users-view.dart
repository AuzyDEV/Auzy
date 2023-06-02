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
                            ((snapshot.data[index].displayName.toLowerCase().contains(searchString)) ||
                            (snapshot.data[index].email.toLowerCase().contains(searchString)))
                          ? 
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: 
                          Container(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.asset(
                                      '../assets/images/user.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                          child: Text(
                                            '${snapshot.data[index].displayName}',
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                child: Text(
                                                  '${snapshot.data[index].email}',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfillWidget(id: snapshot.data[index].id.toString())));
                                    },
                                    child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                      child: Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        size: 24,
                                      ),
                                    ),
                                  ),

                                  )
                                  ],
                              ),
                            )
                          )
                        )
                      : Container()
                      );
                    } else if (snapshot.hasError) {
                      return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                          child: Text('No doctors',
                            textAlign: TextAlign.center,
                            style: FlutterAppTheme.of(context).bodyText2.override(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )
                          )
                      );
                    }
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 280, 0, 0),
                      child: CircularProgressIndicatorWidget(),
                    );
                  }
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
