import 'package:new_mee/themes/label-row.dart';
import 'package:new_mee/themes/text-field.dart';
import 'package:new_mee/user-profile/profile-model.dart';

import '../../themes/alert-popup.dart';
import '../../themes/app-bar-widget.dart';
import '../../themes/custom-button-widget.dart';
import '../../themes/loading-spinner.dart';
import '../../themes/theme.dart';
import 'package:new_mee/home/home-view.dart';
import '../themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:new_mee/user-profile/profile-controller.dart';

class changePasswordWidget extends StatefulWidget {
  const changePasswordWidget({Key key}) : super(key: key);

  @override
  _changePasswordWidgetState createState() => _changePasswordWidgetState();
}

class _changePasswordWidgetState extends State<changePasswordWidget> {
  TextEditingController passwordController;
  TextEditingController passwordController1;
  bool passwordVisibility, passwordVisibility1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  ProfilingMan api = ProfilingMan();
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    passwordController1 = TextEditingController();
    passwordVisibility = false;
    passwordVisibility1 = false;
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
                                      child: LabeledRowWidget(text: 'Password'),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 10, 16, 0),
                                      child: TextFormFieldWidget(
                                        controller: passwordController,
                                        obscureText: !passwordVisibility,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 20, 16, 0),
                                child:
                                    LabeledRowWidget(text: 'Confirm password'),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 10, 16, 10),
                                child: TextFormFieldWidget(
                                  controller: passwordController1,
                                  validator: (value) => value.isEmpty
                                      ? 'Field is required'
                                      : (value != passwordController.text
                                          ? 'Please confirm your password'
                                          : null),
                                  obscureText: !passwordVisibility1,
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
                                                  bool response =
                                                      await api.ChangePassword(
                                                          passwordController
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
                                                                TextButton(
                                                                  child: Text(
                                                                      "Ok"),
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
                                                            return alertDialogWidget(
                                                              title: "Error!",
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

                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicatorWidget());
              })),
    );
  }
}
