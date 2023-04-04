import 'package:new_mee/admin-functions/user-management/profil-user/profil-user-controller.dart';
import 'package:new_mee/themes/text-field.dart';

import '../../../themes/app-bar-widget.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/loading-spinner.dart';
import '../../../themes/modal-bottom.dart';
import '../../../themes/theme.dart';
import 'package:new_mee/user-profile/profile-model.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';

import '../all-users/all-users-controller.dart';

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
  ProfilUserMan api = ProfilUserMan();
  Future<User> _futureUser;
  String a;
  String ipadress;

  @override
  void initState() {
    super.initState();
    idtextController = TextEditingController();
    fullnameController = TextEditingController();
    photoURLtextController = TextEditingController();
    _futureUser = api.GetUser(widget.id);
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                          '${snapshot.data.photoURL}',
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 12),
                                  child: Text('${snapshot.data.displayName}',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: FlutterAppTheme.of(context)
                                              .TextColor)),
                                ),
                                Divider(
                                  height: 40,
                                  color: Colors.grey[50],
                                  endIndent: 20,
                                  indent: 20,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 8),
                                  child: TextFormFieldWidget(
                                    hintText: '${snapshot.data.id}',
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 8, 8, 8),
                                  child: TextFormFieldWidget(
                                    hintText: '${snapshot.data.email}',
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 8, 8, 8),
                                  child: TextFormFieldWidget(
                                    hintText: '${snapshot.data.photoURL}',
                                    readOnly: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buttonWidget(
                                        onPressed: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor:
                                                FlutterAppTheme.of(context)
                                                    .primaryBtnText,
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: Container(
                                                  height: 300,
                                                  child: ShowIpAdressWidget(
                                                      id: widget.id),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        text: 'get IP adress',
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

                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicatorWidget());
              })),
    );
  }
}
