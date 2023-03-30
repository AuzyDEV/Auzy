import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../../services/User_api.dart';
import '../../themes/theme.dart';
import '../../views/signin/signin.dart';
import '../Button_widget.dart';
import '../Error_AlertDialog.dart';
import '../customized_AlertDialog.dart';

class AddUserWidget extends StatefulWidget {
  //final List<Widget> children;
  //final Function(Map<String, dynamic>) onSubmit;

  const AddUserWidget({
    Key key,
  }) : super(key: key);

  @override
  _AddUserWidgetState createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formValues = {};
  static final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController photourlController = TextEditingController();
  bool passwordVisibility = false;
  UserMan api = UserMan();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Full Name*',
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                  child: TextFormField(
                    controller: fullnameController,
                    cursorColor: Color(0xFF9457FB),
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      errorStyle:
                          FlutterAppTheme.of(context).bodyText1.override(
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
                          EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    ),
                    style: FlutterAppTheme.of(context).bodyText1.override(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Photo url*',
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          cursorColor: Color(0xFF9457FB),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value.isEmpty ? 'Filed is required' : null,
                          controller: photourlController,
                          obscureText: false,
                          decoration: InputDecoration(
                            errorStyle:
                                FlutterAppTheme.of(context).bodyText1.override(
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
                                EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          ),
                          style: FlutterAppTheme.of(context).bodyText1.override(
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
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email*',
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
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
                          FlutterAppTheme.of(context).bodyText1.override(
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
                          EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    ),
                    style: FlutterAppTheme.of(context).bodyText1.override(
                        fontFamily: 'Roboto',
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password*',
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
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
                      errorStyle:
                          FlutterAppTheme.of(context).bodyText1.override(
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
                          EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    ),
                    style: FlutterAppTheme.of(context).bodyText1.override(
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
                  padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 10),
                  child: Row(children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: buttonWidget(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
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
                                      builder: (BuildContext context) {
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
                                      builder: (BuildContext context) {
                                        return errorAlertDialogWidget(
                                          content: "$response",
                                        );
                                      });
                            }
                          },
                          text: "save",
                        ),
                      ),
                    ),
                  ])),
            ],
          ),
        ],
      ),
    );
  }
}
