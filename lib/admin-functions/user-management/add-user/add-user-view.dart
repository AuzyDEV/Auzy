import '../../../authentification/create-account/create-account-controller.dart';
import '../../../index.dart';
import '../../../user-profile/profile-controller.dart';
import '../../../themes/theme.dart';
import '../../../user-profile/profile-model.dart';
import 'package:flutter/material.dart';
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
  final formKey = GlobalKey<FormState>();
  ProfilingMan profilingServices = ProfilingMan();
  CreateAccountMan signinUserServices = CreateAccountMan();
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    fullnameController = TextEditingController();
    passwordController = TextEditingController();
    photourlController = TextEditingController();
    passwordVisibility = false;
    _futureUser = profilingServices.GetCurrentUser();
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
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      LabeledRowWidget(text: 'Full Name'),
                      TextFormFieldWidget(
                        controller: fullnameController,
                        isRequired: true,
                        isString: true,
                      ),
                      LabeledRowWidget(text: 'Photo url'),
                      TextFormFieldWidget(
                        controller: photourlController,
                        isRequired: true,
                      ),
                      LabeledRowWidget(text: 'Email'),
                      TextFormFieldWidget(
                        controller: emailAddressController,
                        isRequired: true,
                        isEmail: true,
                      ),
                      LabeledRowWidget(text: 'Password'),
                      TextFormFieldWidget(
                        controller: passwordController,
                        isRequired: true,
                        isPassword: true,
                        obscureText: !passwordVisibility,
                      ),
                    ],
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: CustomButton(
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      String response =
                                          await signinUserServices.signupUser(
                                        emailAddressController.text,
                                        passwordController.text,
                                        fullnameController.text,
                                      );
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
                                              builder: (BuildContext context) {
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
          ],
        ));
  }
}
