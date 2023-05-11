import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../authentification/create-account/create-account-controller.dart';
import '../../../index.dart';
import '../../../themes/password-text-field.dart';
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
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  ProfilingMan profilingServices = ProfilingMan();
  String fileName = "No file selected";
  String errorText;
  Uint8List fileContents;
  CreateAccountMan createAccountUserServices = CreateAccountMan();
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    fullnameController = TextEditingController();
    passwordController = TextEditingController();
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
                        LabeledRowWidget(text: 'Email'),
                        TextFormFieldWidget(
                          controller: emailAddressController,
                          isRequired: true,
                          isEmail: true,
                        ),
                        LabeledRowWidget(text: 'Password'),
                        PasswordFormField(
                          controller: passwordController,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fileName ?? 'No file chosen',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: (() {
                                InputElement inputElement =
                                    FileUploadInputElement();
                                inputElement.click();
                                inputElement.onChange.listen((e) {
                                  final files = inputElement.files;
                                  if (files.length == 1) {
                                    final file = files[0];
                                    fileName = file.name;
                                    final reader = FileReader();
                                    reader.readAsArrayBuffer(file);
                                    reader.onLoadEnd.listen((e) {
                                      setState(() {
                                        fileContents = reader.result;
                                      });
                                    });
                                  } else {
                                    setState(() {
                                      fileName = null;
                                      fileContents = null;
                                      errorText = 'Please choose a file';
                                    });
                                  }
                                });
                              }),
                              child: Text("Pick a file"),
                            ),
                          ],
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
                                child: CustomButton(
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      if (fileContents == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackbarWidget(
                                            content: Text(
                                              'Please select a file!',
                                            ),
                                          ),
                                        );
                                      } else {
                                        String response =
                                            await createAccountUserServices
                                                .signupUser(
                                                    emailAddressController.text,
                                                    passwordController.text,
                                                    fullnameController.text);

                                        await FirebaseStorage.instance
                                            .ref('posts/$response/$fileName')
                                            .putData(fileContents);
                                        showDialog(
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
                                            });
                                      }
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
        ));
  }
}
