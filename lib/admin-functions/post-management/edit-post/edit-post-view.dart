import 'package:new_mee/admin-functions/post-management/edit-post/edit-post-controller.dart';
import 'package:new_mee/themes/label-row.dart';
import 'package:new_mee/themes/text-field.dart';

import '../../../themes/app-bar-widget.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/theme.dart';

import 'package:new_mee/user-profile/profile-model.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';

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
  EditPostMan apiPost = EditPostMan();
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    titleController.text = widget.title.toString();
    contenuController = TextEditingController();
    contenuController.text = widget.contenu.toString();
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
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
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
                          child: LabeledRowWidget(text: 'Post\'s title'),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                          child: TextFormFieldWidget(
                            controller: titleController,
                            isRequired: true,
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Post\'s contenu')),
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
                                child: buttonWidget(
                                  /* onPressed: () async {
                                      if (formKey.currentState.validate()) {
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
                                                return alertDialogWidget(
                                                  title: "Succes!",
                                                  content: 
                                                      "updating infos completed successfully!",
                                                  actions: [
                                                    TextButton(
                                                      child: Text("ok"),
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
                                                return errorAlertDialogWidget(
                                                  content: "$response",
                                              
                                                );
                                              });
                                    }
                                  },*/
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
      )),
    );
  }
}
