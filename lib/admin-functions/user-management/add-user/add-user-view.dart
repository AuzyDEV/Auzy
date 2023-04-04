import 'package:new_mee/authentification/create-account/create-account-controller.dart';
import 'package:new_mee/home/home-view.dart';
import 'package:new_mee/themes/label-row.dart';
import 'package:new_mee/themes/text-field.dart';
import 'package:new_mee/user-profile/profile-controller.dart';
import '../../../authentification/login/login-view.dart';
import '../../../themes/alert-popup.dart';
import '../../../themes/app-bar-widget.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/left-drawer.dart';
import '../../../themes/theme.dart';
import '../../../index.dart';
import 'package:new_mee/user-profile/profile-model.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import '../all-users/all-users-controller.dart';

class addUserWidget extends StatefulWidget {
  const addUserWidget({Key key}) : super(key: key);

  @override
  _addUserWidgetState createState() => _addUserWidgetState();
}

class _addUserWidgetState extends State<addUserWidget> {
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
  ProfilingMan apii = ProfilingMan();
  CreateAccountMan apiAuth = CreateAccountMan();
  bool switchListTileValue;
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    fullnameController = TextEditingController();
    passwordController = TextEditingController();
    photourlController = TextEditingController();
    passwordVisibility = false;
    _futureUser = apii.GetCurrentUser();
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
          child: appbar(text: 'Add user'),
        ),
        drawer: Drawerr(),
        body: Column(
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Full Name'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: fullnameController,
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
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Photo url'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: photourlController,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Email'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: emailAddressController,
                              validator: (value) => value.isEmpty
                                  ? 'Field is required'
                                  : (emailReg.hasMatch(value)
                                      ? null
                                      : 'Enter a Valid email'),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Password'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: passwordController,
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
                                        String response =
                                            await apiAuth.signupUser(
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
                                                builder:
                                                    (BuildContext context) {
                                                  return alertDialogWidget(
                                                    title: "Error!",
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
              ),
            ),
          ],
        ));
  }
}
