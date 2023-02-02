import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/apis/mailingMan.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/components/drawer.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/models/User.dart';
import 'package:new_mee/components/icon_button.dart';
import 'package:new_mee/components/theme.dart';
import 'package:new_mee/components/util.dart';
import 'package:new_mee/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class contactUsWidget extends StatefulWidget {
  const contactUsWidget({Key key}) : super(key: key);

  @override
  _contactUsWidgetState createState() => _contactUsWidgetState();
}

class _contactUsWidgetState extends State<contactUsWidget> {
  TextEditingController emailAddressController;
  TextEditingController fullnameController;
  TextEditingController messageController;
  final TextEditingController mobilecontroller = TextEditingController();
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final formKey = GlobalKey<FormState>();
  MaillingMan Maillingapi = MaillingMan();
  bool switchListTileValue;
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    fullnameController = TextEditingController();
    messageController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appbar(text: 'Contact us'),
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
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Name*',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormField(
                              controller: fullnameController,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your full name' : null,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Enter your full name...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF9DA3A9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF9DA3A9),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF9DA3A9),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 16),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email*',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormField(
                              controller: emailAddressController,
                              validator: (value) => value.isEmpty
                                  ? 'Enter user email'
                                  : (emailReg.hasMatch(value)
                                      ? null
                                      : 'Enter a Valid email'),
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Enter user email...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF9DA3A9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF9DA3A9),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF9DA3A9),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 16),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Mobile*',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                              },
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your mobile' : null,
                              onInputValidated: (bool value) {
                                print(value);
                              },
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: mobilecontroller,
                              formatInput: true,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              inputBorder: OutlineInputBorder(),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Message*',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormField(
                              controller: messageController,
                              maxLines: 8,
                              validator: (value) =>
                                  value.isEmpty ? 'Enter your message' : null,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Enter your message...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF9DA3A9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF9DA3A9),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF9DA3A9),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 16),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
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
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        bool response = await Maillingapi
                                            .ContactUsWithEmail(
                                                emailAddressController.text,
                                                fullnameController.text,
                                                mobilecontroller.text,
                                                messageController.text);
                                        print(response);
                                        response == true
                                            ? showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Succes!"),
                                                    content: Text(
                                                        "Email was sent successfully"),
                                                    actions: [
                                                      FlatButton(
                                                        child: Text("Ok"),
                                                        onPressed: () async {
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MenuWidget(),
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
                                                  return AlertDialog(
                                                    title: Text("Error"),
                                                    content: Text("$response"),
                                                    actions: [
                                                      FlatButton(
                                                        child: Text("Ok"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                      }
                                    },
                                    text: 'send',
                                    options: FFButtonOptions(
                                      height: 45,
                                      color: Color(0xff132137),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ])),
                        Divider(
                          thickness: 1,
                          indent: 50,
                          endIndent: 50,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }
}
