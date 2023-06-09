import 'package:skeleton/admin-functions/user-management/all-users/all-users-controller.dart';

import '../../../index.dart';
import 'profil-user-controller.dart';
import '../../../themes/theme.dart';
import '../../../user-profile/profile-model.dart';
import 'package:flutter/material.dart';

class ProfillWidget extends StatefulWidget {
  final String id;
  const ProfillWidget({Key key, this.id}) : super(key: key);

  @override
  _ProfillWidgetState createState() => _ProfillWidgetState();
}

class _ProfillWidgetState extends State<ProfillWidget> {
  TextEditingController idtextController;
  TextEditingController fullnameController;
  TextEditingController photoURLtextController;
  bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProfilUserMan profilingUserServices = ProfilUserMan();
  Future<User> _futureUser;
  UserMan userServices = UserMan();

  @override
  void initState() {
    super.initState();
    idtextController = TextEditingController();
    fullnameController = TextEditingController();
    photoURLtextController = TextEditingController();
    _futureUser = profilingUserServices.GetUser(widget.id);
  }

  @override
  void dispose() {
    idtextController?.dispose();
    fullnameController?.dispose();
    photoURLtextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: ' User profil'),
      ),
      drawer: Drawerr(),
      body: SingleChildScrollView(
        child: FutureBuilder<User>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: FlutterAppTheme.of(context).whiteColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration( shape: BoxShape.circle,),
                                  child: Image.asset(
                                    "../../assets/images/user.png",
                                    fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB( 0, 12, 0, 12),
                              child: Text('${snapshot.data.displayName}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: FlutterAppTheme.of(context).TextColor
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
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
                                                    userServices.deleteUser(snapshot.data.id.toString()),
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => HomeWidget(),
                                                      ),
                                                    ),
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackbarWidget(
                                                        content: Text('Successfully User deleted!',
                                                        )
                                                      )
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
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => editprofilWidget(id: snapshot.data.id.toString(), name: snapshot.data.displayName, email: snapshot.data.email, photourl: snapshot.data.photoURL.toString()),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 30,
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  snapshot.data.disabled == false ? 
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          var confirmDialogResponse = await showDialog<bool>(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return alertDialogWidget(
                                                title: 'Block user',
                                                content: 'Are you sure to block this user ?',
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(alertDialogContext, false),
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => {
                                                      userServices.BlockUser(snapshot.data.id.toString()),
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
                                              color: Colors.orange,
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
                                                        userServices.RestoreUser(snapshot.data.id.toString()),
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => usersnewWidget(),
                                                          ),
                                                        ),
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackbarWidget(
                                                          content: Text( 'Successfully User restored!',),
                                                          )
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
                                                Icons.repeat_rounded,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ),
                                ]
                              )
                            ),
                            
                            LabeledRowWidget(
                              text: "User id ",
                            ),
                            TextFormFieldWidget(
                              hintText: '${snapshot.data.id}',
                              readOnly: true,
                            ),
                            LabeledRowWidget(
                              text: "User email ",
                            ),
                            TextFormFieldWidget(
                              hintText: '${snapshot.data.email}',
                              readOnly: true,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: FlutterAppTheme.of(context).primaryBtnText,
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding:  MediaQuery.of(context).viewInsets,
                                              child: Container(
                                                height: 300,
                                                child: ShowIpAdressWidget( id: widget.id),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      text: 'Get IP adress',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 280, 0, 0),
              child: CircularProgressIndicatorWidget(),
            );
          }
        )
      ),
    );
  }
}
