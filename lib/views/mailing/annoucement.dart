import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:new_mee/services/mailingMan.dart';
import 'package:new_mee/common_widgets/Button_widget.dart';
import 'package:new_mee/common_widgets/customized_AlertDialog.dart';
import 'package:new_mee/common_widgets/error_AlertDialog.dart';
import 'package:new_mee/common_widgets/app_bar.dart';
import 'package:new_mee/common_widgets/drawer.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/themes/theme.dart';
import 'package:new_mee/common_widgets/FFButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:new_mee/views/home/home_widget.dart';

class announcementWidget extends StatefulWidget {
  const announcementWidget({Key key}) : super(key: key);

  @override
  _announcementWidgetState createState() => _announcementWidgetState();
}

class _announcementWidgetState extends State<announcementWidget> {
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
          child: appbar(text: 'Annoucement'),
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
                                  'Message*',
                                  style: FlutterAppTheme.of(context)
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
                              cursorColor: Color(0xFF9457FB),
                              validator: (value) =>
                                  value.isEmpty ? 'Field is required' : null,
                              obscureText: false,
                              decoration: InputDecoration(
                                errorStyle: FlutterAppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal,
                                    ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x988B97A2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x988B97A2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: 'Enter your message...',
                                hintStyle: FlutterAppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Roboto',
                                      color: Color(0xFF9DA3A9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 16, 20, 16),
                              ),
                              style: FlutterAppTheme.of(context)
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
                                  child: buttonWidget(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        bool response = await Maillingapi
                                            .sendBroadcastEmail(
                                                messageController.text);
                                        print(response);
                                        response == true
                                            ? showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alertDialogWidget(
                                                    title: "Succes!",
                                                    content:
                                                        "Email was sent successfully",
                                                    actions: [
                                                      ElevatedButton(
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
                                                  return errorAlertDialogWidget(
                                                    content: "$response",
                                                  );
                                                });
                                      }
                                    },
                                    text: 'send',
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
}
