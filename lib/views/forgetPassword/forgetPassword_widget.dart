import 'package:new_mee/services/User_api.dart';
import 'package:new_mee/common_widgets/Button_widget.dart';
import 'package:new_mee/common_widgets/customized_AlertDialog.dart';
import 'package:new_mee/common_widgets/error_AlertDialog.dart';
import '../../themes/theme.dart';
import '../../common_widgets/FFButtonWidget.dart';
import 'package:flutter/material.dart';

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
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Reset ',
                              style: FlutterAppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF9457FB),
                                    fontSize: 30,
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'password',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 30,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Enter the email associated with your account',
                            style: FlutterAppTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Open Sans',
                                  color:
                                      FlutterAppTheme.of(context).secondaryText,
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
                                FlutterAppTheme.of(context).bodyText2.override(
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
                        padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
                        child: Row(children: [
                          Expanded(
                            child: buttonWidget(
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
                                            return alertDialogWidget(
                                              title: "Succes",
                                              content: "$response",
                                              actions: [
                                                ElevatedButton(
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
                                            return errorAlertDialogWidget(
                                              content: "$response",
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
                                            ElevatedButton(
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
