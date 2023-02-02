import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/index.dart';
import '../components/theme.dart';
import '../components/util.dart';
import '../components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetpasswordWidget extends StatefulWidget {
  const ForgetpasswordWidget({Key key}) : super(key: key);

  @override
  _ForgetpasswordWidgetState createState() => _ForgetpasswordWidgetState();
}

class _ForgetpasswordWidgetState extends State<ForgetpasswordWidget> {
  TextEditingController emailAddressController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  static final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String response;
  int clickCount = 0;
  UserMan api = UserMan();
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 80, 16, 25),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF101213),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reset Password',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      fontSize: 30,
                                    ),
                          ),
                          Text(
                            'Enter the email associated with your account',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style:
                                FlutterFlowTheme.of(context).bodyText2.override(
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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                      child: TextFormField(
                        controller: emailAddressController,
                        validator: (value) => value.isEmpty
                            ? 'Enter your email'
                            : (emailReg.hasMatch(value)
                                ? null
                                : 'Enter a Valid email'),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF9DA3A9),
                                  ),
                          hintText: 'Enter your email...',
                          hintStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF9DA3A9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF9DA3A9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF9DA3A9),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Roboto',
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                        child: Row(children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                clickCount = clickCount + 1;
                                if (formKey.currentState.validate()) {
                                  response = await api.resetpasswordUser(
                                      emailAddressController.text);
                                  print(response);
                                }
                                if (clickCount < 4) {
                                  response == "email reset password send!"
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Succes"),
                                              content: Text("$response"),
                                              actions: [
                                                FlatButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          })
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text("$response"),
                                              actions: [
                                                FlatButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                } else
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Error"),
                                          content: Text(
                                              "3 requests! We have blocked requests to unusual activity. Try again later."),
                                          actions: [
                                            FlatButton(
                                              child: Text("Ok"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                              },
                              text: 'Send',
                              options: FFButtonOptions(
                                height: 45,
                                color: Color(0xff132137),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          )
                        ])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
