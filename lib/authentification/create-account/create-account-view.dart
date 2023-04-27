import '../../index.dart';
import 'create-account-controller.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';

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
            Form(
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
