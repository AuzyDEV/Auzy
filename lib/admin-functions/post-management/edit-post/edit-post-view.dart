import '../../../index.dart';
import 'edit-post-controller.dart';
import '../../../themes/theme.dart';
import 'package:html_editor_enhanced/html_editor.dart';
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
  HtmlEditorController controller = HtmlEditorController();
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  EditPostMan editPostServices = EditPostMan();
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    titleController.text = widget.title.toString();
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
          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    LabeledRowWidget(text: 'Post\'s title'),
                    TextFormFieldWidget(
                      controller: titleController,
                      isRequired: true,
                    ),
                    LabeledRowWidget(text: 'Post\'s contenu'),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                      child: Column(
                        children: [
                          HtmlEditor(
                            controller: controller,
                            htmlEditorOptions: HtmlEditorOptions(
                              hint: "Your text here...",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 10),
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: CustomButton(
                                onPressed: () async {
                                  String text = await controller.getText();
                                  if (formKey.currentState.validate()) {
                                    bool response = await editPostServices.UpdatePostInfos( widget.id, titleController.text,text);
                                    if (response == true) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => postsNewWidget(),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackbarWidget(
                                          content: Text( 'Successfully post updated!',
                                          ),
                                        ),
                                      );
                                    } else
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alertDialogWidget(
                                              title: "Error",
                                              content: "$response",
                                            );
                                          }
                                      );
                                  }
                                },
                                text: 'submit',
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
    ),
    );
  }
}
