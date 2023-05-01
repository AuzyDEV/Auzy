import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../index.dart';
import 'add-post-controller.dart';
import '../../../user-profile/profile-controller.dart';
import '../../../themes/theme.dart';
import '../../../user-profile/profile-model.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class addNewPostWidget extends StatefulWidget {
  const addNewPostWidget({Key key}) : super(key: key);

  @override
  _addNewPostWidgetState createState() => _addNewPostWidgetState();
}

class _addNewPostWidgetState extends State<addNewPostWidget> {
  TextEditingController titleController;
  TextEditingController TextController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  ProfilingMan apiUser = ProfilingMan();
  Future<User> _futureUser;
  AddPostMan apiPost = AddPostMan();
  File _selectedFile;
  String fileName = "No file selected";
  Uint8List fileContents;
  HtmlEditorController controller = HtmlEditorController();
  void _pickFile() {
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
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _futureUser = apiUser.GetCurrentUser();
    titleController = TextEditingController();
    TextController = TextEditingController();
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
          child: appbar(text: 'New Post'),
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
                        Form(
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
                                    LabeledRowWidget(text: 'Title'),
                                    TextFormFieldWidget(
                                      controller: titleController,
                                      isRequired: true,
                                    ),
                                    LabeledRowWidget(text: 'Text'),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 20, 16, 0),
                                  child: Column(children: [
                                    HtmlEditor(
                                      controller: controller, //required
                                      htmlEditorOptions: HtmlEditorOptions(
                                        hint: "Your text here...",
                                        initialText:
                                            "text content initial, if any",
                                      ),
                                    ),
                                  ])),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(fileName),
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
                                        }
                                      });
                                    }),
                                    child: Text("Pick a file"),
                                  ),
                                ],
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
                                                String text =
                                                    await controller.getText();
                                                String test = text.substring(
                                                    1, text.length - 1);
                                                print(text.toString());
                                                if (formKey.currentState
                                                    .validate()) {
                                                  String response =
                                                      await apiPost.addNewPost(
                                                          titleController.text,
                                                          text.toString(),
                                                          snapshot.data.id,
                                                          snapshot
                                                              .data.displayName,
                                                          snapshot
                                                              .data.photoURL);
                                                  await FirebaseStorage.instance
                                                      .ref(
                                                          'posts/$response/$fileName')
                                                      .putData(fileContents);

                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return alertDialogWidget(
                                                          title: "Succes!",
                                                          content:
                                                              "Post was added successfully",
                                                          actions: [
                                                            TextButton(
                                                              child: Text("Ok"),
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
                                                      });
                                                }
                                              },
                                              text: 'send',
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
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(child: const CircularProgressIndicatorWidget());
                })));
  }
}
