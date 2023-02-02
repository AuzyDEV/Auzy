import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/models/User.dart';
import 'package:new_mee/components/theme.dart';
import 'package:new_mee/components/util.dart';
import 'package:new_mee/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class editprofilWidget extends StatefulWidget {
  final String id, name, email, photourl;
  const editprofilWidget(
      {Key key, this.id, this.email, this.name, this.photourl})
      : super(key: key);

  @override
  _editprofilWidgetState createState() => _editprofilWidgetState();
}

class _editprofilWidgetState extends State<editprofilWidget> {
  TextEditingController emailAddressController;
  TextEditingController fullnameController;
  TextEditingController photourlController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final formKey = GlobalKey<FormState>();
  bool futurepost;
  UserMan api = UserMan();
  bool switchListTileValue;
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    emailAddressController.text = widget.email.toString();
    fullnameController = TextEditingController();
    fullnameController.text = widget.name.toString();
    photourlController = TextEditingController();
    photourlController.text = widget.photourl.toString();
    passwordVisibility = false;
    _futureUser = api.GetCurrentUser();
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
        child: appbar(text: 'Edit profil'),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<User>(
              future: _futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 20, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Full Name*',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF101213),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 10, 16, 0),
                                      child: TextFormField(
                                        controller: fullnameController,
                                        validator: (value) => value.isEmpty
                                            ? 'Enter your full name'
                                            : null,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your full name...',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF9DA3A9),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF9DA3A9),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF9DA3A9),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 16, 20, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 20, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Photo url*',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF101213),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 10, 16, 0),
                                      child: TextFormField(
                                        controller: photourlController,
                                        validator: (value) => value.isEmpty
                                            ? 'Enter your photo url'
                                            : null,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your photo url...',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF9DA3A9),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF9DA3A9),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF9DA3A9),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 16, 20, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 20, 16, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Email*',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: Color(0xFF101213),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 10, 16, 0),
                                      child: TextFormField(
                                        controller: emailAddressController,
                                        validator: (value) => value.isEmpty
                                            ? 'Enter your email'
                                            : (emailReg.hasMatch(value)
                                                ? null
                                                : 'Enter a Valid email'),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your email...',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF9DA3A9),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF9DA3A9),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF9DA3A9),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 16, 20, 16),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 30, 16, 10),
                                      child: Row(children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                if (formKey.currentState
                                                    .validate()) {
                                                  bool response = await api
                                                      .UpdateprofilUser(
                                                          widget.id,
                                                          emailAddressController
                                                              .text,
                                                          fullnameController
                                                              .text,
                                                          photourlController
                                                              .text);
                                                  print(response);
                                                  response == true
                                                      ? showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Succes!"),
                                                              content: Text(
                                                                  "updating infos completed successfully!"),
                                                              actions: [
                                                                FlatButton(
                                                                  child: Text(
                                                                      "ok"),
                                                                  onPressed:
                                                                      () async {
                                                                    await Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                MenuWidget(),
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
                                                                  "$response"),
                                                              actions: [
                                                                FlatButton(
                                                                  child: Text(
                                                                      "Ok"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          });
                                                }
                                              },
                                              text: 'submit',
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
                                      ])),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicator());
              })),
    );
  }
}
