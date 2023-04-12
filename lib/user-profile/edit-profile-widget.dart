import '../index.dart';
import 'profile-controller.dart';
import 'profile-model.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';

class editprofilWidget extends StatefulWidget {
  final String id, name, email, photourl;
  const editprofilWidget(
      {Key key, this.id, this.email, this.name, this.photourl})
      : super(key: key);

  @override
  _editprofilWidgetState createState() => _editprofilWidgetState();
}

class _editprofilWidgetState extends State<editprofilWidget> {
  TextEditingController emailAddressController;
  TextEditingController fullnameController;
  TextEditingController photourlController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final formKey = GlobalKey<FormState>();
  bool futurepost;
  ProfilingMan api = ProfilingMan();
  bool switchListTileValue;
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    emailAddressController.text = widget.email.toString();
    fullnameController = TextEditingController();
    fullnameController.text = widget.name.toString();
    photourlController = TextEditingController();
    photourlController.text = widget.photourl.toString();
    passwordVisibility = false;
    _futureUser = api.GetCurrentUser();
    print(widget.name);
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
                                      child:
                                          LabeledRowWidget(text: 'Full Name'),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 10, 16, 0),
                                      child: TextFormFieldWidget(
                                        controller: fullnameController,
                                        isRequired: true,
                                        isString: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 20, 16, 0),
                                      child:
                                          LabeledRowWidget(text: 'Photo url'),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 10, 16, 0),
                                      child: TextFormFieldWidget(
                                        controller: photourlController,
                                        isRequired: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 20, 16, 0),
                                      child: LabeledRowWidget(text: 'Email'),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 10, 16, 0),
                                      child: TextFormFieldWidget(
                                        controller: emailAddressController,
                                        isRequired: true,
                                        isEmail: true,
                                      ),
                                    ),
                                  ],
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
                                                  bool response = await api
                                                      .UpdateprofilUser(
                                                          widget.id,
                                                          emailAddressController
                                                              .text,
                                                          fullnameController
                                                              .text,
                                                          photourlController
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
                                                                ElevatedButton(
                                                                  child: Text(
                                                                      "ok"),
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

                return Center(child: const CircularProgressIndicatorWidget());
              })),
    );
  }
}
