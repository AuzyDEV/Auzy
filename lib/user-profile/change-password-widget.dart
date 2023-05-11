import '../index.dart';
import '../themes/password-text-field.dart';
import 'profile-model.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'profile-controller.dart';

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
  ProfilingMan profilingUserServices = ProfilingMan();
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    passwordController1 = TextEditingController();
    passwordVisibility = false;
    passwordVisibility1 = false;
    _futureUser = profilingUserServices.GetCurrentUser();
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
                      Form(
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
                                  LabeledRowWidget(text: 'Password'),
                                  PasswordFormField(
                                    controller: passwordController,
                                  ),
                                ],
                              ),
                            ),
                            LabeledRowWidget(text: 'Confirm password'),
                            PasswordFormField(
                              controller: passwordController1,
                              validator: (value) => value.isEmpty
                                  ? 'Field is required'
                                  : (value != passwordController.text
                                      ? 'Please confirm your password'
                                      : null),
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
                                          child: CustomButton(
                                            onPressed: () async {
                                              if (formKey.currentState
                                                  .validate()) {
                                                bool response =
                                                    await profilingUserServices
                                                        .ChangePassword(
                                                            passwordController
                                                                .text);
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
                                                                child:
                                                                    Text("Ok"),
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
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: const CircularProgressIndicatorWidget());
              })),
    );
  }
}
