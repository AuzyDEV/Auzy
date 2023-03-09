import 'package:new_mee/apis/DrugsMan.dart';
import 'package:new_mee/apis/medecineMan.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/components/drawer.dart';
import 'package:new_mee/components/widgets.dart';
import 'package:new_mee/drugs/drugsList_widget.dart';
import 'package:new_mee/drugs/updateDrugImage_widget.dart';
import 'package:new_mee/drugs/updateDrug_widget.dart';
import 'package:new_mee/medecines/medecines.dart';
import 'package:new_mee/medecines/updateImageMededcine_widget.dart';
import 'package:new_mee/medecines/updateMedecineInfos_widget.dart';
import 'package:new_mee/models/Medecine.dart';
import 'package:new_mee/components/theme.dart';
import 'package:flutter/material.dart';

class drugDetailsWidget extends StatefulWidget {
  final String id;
  const drugDetailsWidget({Key key, this.id}) : super(key: key);

  @override
  _drugDetailsWidgetState createState() => _drugDetailsWidgetState();
}

class _drugDetailsWidgetState extends State<drugDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<Medecine> _futureMedecine;
  DBMan apiDB = DBMan();
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

  @override
  void initState() {
    super.initState();
    _getFutureRoleValue();
    _futureMedecine = apiDB.getDBDetails(widget.id);
    print(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appbar(text: 'Medecine details'),
        ),
        drawer: Drawerr(),
        body: SingleChildScrollView(
            child: FutureBuilder<Medecine>(
                future: _futureMedecine,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: Hero(
                            tag: 'mainImage',
                            transitionOnUserGestures: true,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                '${snapshot.data.files[0].downloadURL}',
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          child: Text(
                            '${snapshot.data.name}',
                            style: FlutterFlowTheme.of(context).title1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 4),
                          child: Text(
                            '${snapshot.data.type}',
                            textAlign: TextAlign.start,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 0),
                          child: Text(
                            '\$ ${snapshot.data.price}',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).subtitle1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child: Text(
                            '${snapshot.data.desciption}',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                        Divider(
                          height: 24,
                          thickness: 2,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        if (_futureRoleValue == "admin")
                          Column(children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                updateDrugWidget(
                                                    id: widget.id.toString(),
                                                    name: snapshot.data.name,
                                                    desciption: snapshot
                                                        .data.desciption,
                                                    type: snapshot.data.type),
                                          ),
                                        );
                                      },
                                      text: 'update medecine\'s infos',
                                      options: FFButtonOptions(
                                        width: 160,
                                        height: 40,
                                        color: Colors.blue,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        elevation: 3,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                updateImageDrugWidget(
                                                    id: widget.id.toString(),
                                                    downloadURL: snapshot.data
                                                        .files[0].downloadURL),
                                          ),
                                        );
                                      },
                                      text: 'update medecine\'s photo',
                                      options: FFButtonOptions(
                                        width: 160,
                                        height: 40,
                                        color: Colors.green,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        elevation: 3,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'delete medecine'),
                                                      content: Text(
                                                          'Are you sure to delete this medecine?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext,
                                                                  false),
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () => {
                                                            apiDB.deleteDrug(
                                                                widget.id),
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DrugsListWidget(),
                                                              ),
                                                            ),
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                    'Successfully medecine deleted!',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red),
                                                            ),
                                                          },
                                                          child:
                                                              Text('Confirm'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ) ??
                                                false;
                                      },
                                      text: 'Delete medecine',
                                      options: FFButtonOptions(
                                        width: 160,
                                        height: 40,
                                        color: Colors.red,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        elevation: 3,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return Center(child: const CircularProgressIndicator());
                })));
  }
}
