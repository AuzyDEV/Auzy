import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
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
  TextEditingController passwordController;
  bool passwordVisibility;
  String fileName = "No file selected";
  String errorText;
  Uint8List fileContents;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool futurepost;
  CreateAccountMan createAccountUserServices = CreateAccountMan();

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    fullnameController = TextEditingController();
    passwordController = TextEditingController();
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
                      color: FlutterAppTheme.of(context).LightDarkTextColor,
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
                  Text('Create',
                    style: FlutterAppTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      fontSize: 30,
                    ),
                  ),
                  Text('Account',
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
                        LabeledRowWidget(text: 'Email'),
                        TextFormFieldWidget(
                          controller: emailAddressController,
                          isRequired: true,
                          isEmail: true,
                        ),
                        LabeledRowWidget(text: 'Password'),
                        PasswordFormField(
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
                        ),
                        LabeledRowWidget(text: 'Select photo'),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: FlutterAppTheme.of(context).tabBarText,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      InputElement inputElement = FileUploadInputElement();
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
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          '../assets/images/upload.png',
                                          width: 50,
                                          height: 50,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Upload Photo',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: FlutterAppTheme.of(context).primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text( fileName ?? 'No file chosen',
                                          style: TextStyle(
                                            color: FlutterAppTheme.of(context).secondaryText,
                                            fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: CustomButton(
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      if (fileContents == null) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Please select a file!'),
                                            backgroundColor: Colors.red,
                                          )
                                        );
                                      } else {
                                        Map<String, String> response = await createAccountUserServices.signupUser(emailAddressController.text, passwordController.text, fullnameController.text);
                                        String result = response['result'];

                                        if (result == "User registred & email send successfully") {
                                          String uid = response['data'];
                                          await FirebaseStorage.instance.ref('users/$uid/$fileName').putData(fileContents);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alertDialogWidget(
                                                title: "Succes!",
                                                content: "Registration completed successfully! please check your email to verify your email adress",
                                                actions: [
                                                  TextButton(
                                                    child: Text("Ok"),
                                                    onPressed: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => SigninWidget(),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              );
                                            }
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alertDialogWidget(
                                                title: "Error!",
                                                content: "$result",
                                                actions: [
                                                  TextButton(
                                                    child: Text("Ok"),
                                                    onPressed: () async {
                                                      await Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              );
                                            }
                                          );
                                        }
                                      }
                                    }
                                  },
                                  text: 'create',
                                ),
                              ),
                            ),
                          ]
                        )
                      ),
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
