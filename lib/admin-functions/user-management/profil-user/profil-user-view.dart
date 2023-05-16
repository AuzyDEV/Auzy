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
                                      child: Image.asset(
                                          "../../assets/images/user.png",
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 20, 16, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  FlutterAppTheme.of(context)
                                                      .primaryBtnText,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding:
                                                      MediaQuery.of(context)
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
              })),
    );
  }
}
