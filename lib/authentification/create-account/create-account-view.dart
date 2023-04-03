import 'package:new_mee/authentification/create-account/create-account-controller.dart';

import '../../../themes/alert-popup.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/theme.dart';
import '../../index.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../login/login-view.dart';

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({Key key}) : super(key: key);

  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
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
  CreateAccountMan api = CreateAccountMan();

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    fullnameController = TextEditingController();
    passwordController = TextEditingController();
    photourlController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0xff132137),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create',
                    style: FlutterAppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          fontSize: 30,
                        ),
                  ),
                  Text(
                    'Account',
                    style: FlutterAppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          fontSize: 30,
                        ),
                  ),
                  Divider(
                    thickness: 3,
                    indent: 5,
                    endIndent: 200,
                    color: FlutterAppTheme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Full Name*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
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
                                if (!isAlpha(value.replaceAll(' ', ''))) {
                                  return 'Requires only characters';
                                }
                                if (value.length < 3) {
                                  return 'Requires at least 3 characters.';
                                }
                                return null;
                              },
                              obscureText: false,
                              decoration: InputDecoration(
                                errorStyle: FlutterAppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal,
                                    ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x988B97A2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x988B97A2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Photo url*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
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
                                  child: TextFormField(
                                    cursorColor: Color(0xFF9457FB),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) => value.isEmpty
                                        ? 'Filed is required'
                                        : null,
                                    controller: photourlController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      errorStyle: FlutterAppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: Colors.red,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x988B97A2),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x988B97A2),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
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
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
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
                                errorStyle: FlutterAppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal,
                                    ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x988B97A2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x988B97A2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Password*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormField(
                              controller: passwordController,
                              cursorColor: Color(0xFF9457FB),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field is required';
                                }
                                if (value.length < 6) {
                                  return 'Requires at least 6 characters.';
                                }
                                return null;
                              },
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                errorStyle: FlutterAppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal,
                                    ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x988B97A2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x988B97A2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 30, 16, 10),
                            child: Row(children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: buttonWidget(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        String response = await api.signupUser(
                                            emailAddressController.text,
                                            passwordController.text,
                                            fullnameController.text,
                                            photourlController.text);
                                        print(response);
                                        response ==
                                                "User registred & email send successfully"
                                            ? showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alertDialogWidget(
                                                    title: "Succes!",
                                                    content:
                                                        "Registration completed successfully! please check your email to verify your email adress",
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Ok"),
                                                        onPressed: () async {
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SigninWidget(),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  );
                                                })
                                            : showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alertDialogWidget(
                                                    title: "Error!",
                                                    content: "$response",
                                                  );
                                                });
                                      }
                                    },
                                    text: 'create',
                                  ),
                                ),
                              ),
                            ])),
                        Divider(
                          thickness: 1,
                          indent: 50,
                          endIndent: 50,
                          color: Colors.grey[300],
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SigninWidget(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Already have an account?',
                                    style: FlutterAppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF9457FB),
                                          decoration: TextDecoration.underline,
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
          ],
        ),
      ),
    );
  }
}
