import 'dart:convert';

import 'package:new_mee/apis/postMan.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/models/User.dart';
import 'package:new_mee/components/theme.dart';
import 'package:new_mee/components/widgets.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_quill/flutter_quill.dart' as quill;

class editPostDetailsWidget extends StatefulWidget {
  final String id, title, contenu;

  const editPostDetailsWidget({
    Key key,
    this.id,
    this.title,
    this.contenu,
  }) : super(key: key);

  @override
  _editPostDetailsWidgetState createState() => _editPostDetailsWidgetState();
}

class _editPostDetailsWidgetState extends State<editPostDetailsWidget> {
  TextEditingController titleController;
  TextEditingController contenuController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  PostMan apiPost = PostMan();
  //quill.QuillController _controller;
  Future<User> _futureUser;
  /* quill.Delta deltaFromJson(String json) {
    final List<dynamic> data = jsonDecode(json);
    final quill.Delta delta = quill.Delta();
    for (final item in data) {
      final String text = item['insert'] as String;
      final Map<String, dynamic> attributes =
          item['attributes'] as Map<String, dynamic>;
      if (attributes != null) {
        delta.insert(text, attributes);
      } else {
        delta.insert(text);
      }
    }
    return delta;
  }
*/
  @override
  void initState() {
    super.initState();
    //_controller = quill.QuillController.basic();
    titleController = TextEditingController();
    titleController.text = widget.title.toString();
    contenuController = TextEditingController();
    contenuController.text = widget.contenu.toString();
    passwordVisibility = false;

    //_futureUser = api.GetCurrentUser();
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
        child: appbar(text: 'Edit Post'),
      ),
      body: SingleChildScrollView(
          child: Column(
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
                                'Post\'s title*',
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
                            controller: titleController,
                            cursorColor: Color(0xFF9457FB),
                            validator: (value) =>
                                value.isEmpty ? 'Field is required' : null,
                            obscureText: false,
                            decoration: InputDecoration(
                              errorStyle: FlutterFlowTheme.of(context)
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
                              contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
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
                                'Post\'s contenu*',
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
                              EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                          child: Column(
                            children: [
                              /* quill.QuillToolbar.basic(controller: _controller),
                              Container(
                                height: 200,
                                child: quill.QuillEditor.basic(
                                  controller: _controller =
                                      quill.QuillController(
                                    document: quill.Document.fromDelta(
                                      deltaFromJson(widget.contenu),
                                    ),
                                    selection:
                                        TextSelection.collapsed(offset: 0),
                                  ),

                                  readOnly: false, // true for view only mode
                                ),
                              ),*/
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 30, 16, 10),
                          child: Row(children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    /*  if (formKey.currentState.validate()) {
                                      var contenu = _controller.document
                                          .toDelta()
                                          .toJson();
                                      bool response =
                                          await apiPost.UpdatePostInfos(
                                              widget.id,
                                              titleController.text,
                                              contenu);
                                      print(response);
                                      response == true
                                          ? showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Succes!"),
                                                  content: Text(
                                                      "updating infos completed successfully!"),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: Text("ok"),
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
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Error"),
                                                  content: Text("$response"),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                    }*/
                                  },
                                  text: 'submit',
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
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
