import '../../index.dart';
import 'login-controller.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';

class SigninWidget extends StatefulWidget {
  const SigninWidget({Key key}) : super(key: key);

  @override
  _SigninWidgetWidgetState createState() => _SigninWidgetWidgetState();
}

class _SigninWidgetWidgetState extends State<SigninWidget> {
  TextEditingController emailAddressController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  SigninMan signinUserServices = SigninMan();
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: SingleChildScrollView(
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
                    Text( 'Sign In',
                      style: FlutterAppTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        fontSize: 30,
                      ),
                    ),
                    Divider(
                      thickness: 3,
                      indent: 5,
                      endIndent: 250,
                      color: Color(0xFF9457FB),
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
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
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  ForgetpasswordWidget(),
                                  ),
                                );
                              },
                              child: Text( 'Forget Password ?',
                                style: FlutterAppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Roboto',
                                  color: FlutterAppTheme.of(context).secondaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  child: CustomButton(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        String response =  await signinUserServices.signinUser(emailAddressController.text, passwordController.text,);
                                        response == "User signin successfully"  
                                        ? await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomeWithButtomNavBarWidget(),
                                            ),
                                          )
                                        : showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alertDialogWidget(
                                                title: "Error!",
                                                content: "$response",
                                              );
                                            }
                                          );
                                      }
                                    },
                                    text: 'Sign In',
                                  ),
                                ),
                              )
                            ]
                          )
                        ),
                        Divider(
                          thickness: 1,
                          indent: 50,
                          endIndent: 50,
                          color: Colors.grey[300],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: Text('Or connect with',
                                  style: FlutterAppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Roboto',
                                    color: FlutterAppTheme.of(context).secondaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  var result = signinUserServices.signInWithGoogle();
                                  if (result != null) {}
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Icon(
                                    Icons.email,
                                    color: FlutterAppTheme.of(context).LightDarkTextColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  var result = signinUserServices.facebookSignin();
                                  if (result != null) {}
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Icon(
                                    Icons.facebook,
                                    color: FlutterAppTheme.of(context).LightDarkTextColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( "Don't have an account? ",
                                style: FlutterAppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Roboto',
                                  color: FlutterAppTheme.of(context).secondaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateAccountWidget(),
                                    ),
                                  );
                                },
                                child: Text("Sign Up",
                                  style: FlutterAppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9457FB),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
