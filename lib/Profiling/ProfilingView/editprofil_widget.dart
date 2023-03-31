import 'package:new_mee/Profiling/ProfilingController/ProfilingController.dart';

import '../../CommonWidgets/Button.dart';
import '../../CommonWidgets/AlertDialog.dart';
import '../../CommonWidgets/LoadingSpinner.dart';
import '../../common_widgets/error_AlertDialog.dart';
import '../../CommonWidgets/AppBar.dart';
import '../../CommonWidgets/LeftDrawer.dart';
import '../../Home/HomeView/home_widget.dart';
import '../ProfilingModel/User.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

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
  ProfilingMan api = ProfilingMan();
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
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Edit profil'),
      ),
      drawer: Drawerr(),
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
                                            style: FlutterAppTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterAppTheme.of(
                                                          context)
                                                      .TextColor,
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
                                        cursorColor: Color(0xFF9457FB),
                                        keyboardType: TextInputType.text,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Field is required';
                                          }
                                          if (!isAlpha(
                                              value.replaceAll(' ', ''))) {
                                            return 'Requires only characters';
                                          }
                                          if (value.length < 3) {
                                            return 'Requires at least 3 characters.';
                                          }
                                          return null;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          errorStyle:
                                              FlutterAppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x988B97A2),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x988B97A2),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 12, 0),
                                        ),
                                        style: FlutterAppTheme.of(context)
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
                                            style: FlutterAppTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterAppTheme.of(
                                                          context)
                                                      .TextColor,
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
                                        cursorColor: Color(0xFF9457FB),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) => value.isEmpty
                                            ? 'Filed is required'
                                            : null,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          errorStyle:
                                              FlutterAppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x988B97A2),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x988B97A2),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 12, 0),
                                        ),
                                        style: FlutterAppTheme.of(context)
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
                                            style: FlutterAppTheme.of(context)
                                                .bodyText2
                                                .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterAppTheme.of(
                                                          context)
                                                      .TextColor,
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
                                        cursorColor: Color(0xFF9457FB),
                                        validator: (value) => value.isEmpty
                                            ? 'Field is required'
                                            : (emailReg.hasMatch(value)
                                                ? null
                                                : 'Enter a Valid email'),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          errorStyle:
                                              FlutterAppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x988B97A2),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x988B97A2),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 12, 0),
                                        ),
                                        style: FlutterAppTheme.of(context)
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
                                            child: buttonWidget(
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
                                                            return alertDialogWidget(
                                                              title: "Succes!",
                                                              content:
                                                                  "updating infos completed successfully!",
                                                              actions: [
                                                                ElevatedButton(
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
                                                                                HomeWidget(),
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
                                                            return errorAlertDialogWidget(
                                                              content:
                                                                  "$response",
                                                            );
                                                          });
                                                }
                                              },
                                              text: 'submit',
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

                return Center(
                    child: const CircularProgressIndicatorWidget());
              })),
    );
  }
}
