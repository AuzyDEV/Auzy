import '../../index.dart';
import 'package:skeleton/themes/theme.dart';
import 'package:flutter/material.dart';
import 'mail-broadcast-controller.dart';

class announcementWidget extends StatefulWidget {
  const announcementWidget({Key key}) : super(key: key);

  @override
  _announcementWidgetState createState() => _announcementWidgetState();
}

class _announcementWidgetState extends State<announcementWidget> {
  TextEditingController messageController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  AnnoucementMan announcementServices = AnnoucementMan();
  
  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
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
        child: appbar(text: 'Annoucement'),
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
                    LabeledRowWidget(text: 'Message'),
                    TextFormFieldWidget(
                      maxLines: 8,
                      controller: messageController,
                      isRequired: true,
                    ),
                  ],
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
                                    bool response = await announcementServices.sendBroadcastEmail(messageController.text);
                                    response == true ? 
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alertDialogWidget(
                                            title: "Succes!",
                                            content: "Email was sent successfully",
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
                                        }
                                      )
                                    : showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alertDialogWidget(
                                            title: "Succes!",
                                            content: "$response",
                                          );
                                        }
                                      );
                                  }
                                },
                                text: 'Send',
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
      )
    );
  }
}
