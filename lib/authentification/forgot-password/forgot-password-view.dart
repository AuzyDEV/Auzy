import '../../index.dart';
import 'forgot-password-controller.dart';
import '../../../themes/theme.dart';
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
  ForgetPasswordMan api = ForgetPasswordMan();
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
                        color: FlutterAppTheme.of(context).AppBarPrimaryColor,
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
                                    color: FlutterAppTheme.of(context)
                                        .primaryColor,
                                    fontSize: 30,
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'password',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
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
                    LabeledRowWidget(text: 'Email'),
                    TextFormFieldWidget(
                      controller: emailAddressController,
                      isRequired: true,
                      isEmail: true,
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
                                                TextButton(
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
                                            return alertDialogWidget(
                                              title: "Error!",
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
