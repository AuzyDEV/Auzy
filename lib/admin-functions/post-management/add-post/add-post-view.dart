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
  ProfilingMan userServices = ProfilingMan();
  Future<User> _futureUser;
  AddPostMan addPostServices = AddPostMan();
  String fileName = "No file selected";
  String errorText;
  Uint8List fileContents;
  HtmlEditorController controller = HtmlEditorController();

  @override
  void initState() {
    super.initState();
    _futureUser = userServices.GetCurrentUser();
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
                                     Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                          child: 
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    fileName ?? 'No file chosen',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                                        } else {
                                          setState(() {
                                            fileName = null;
                                            fileContents = null;
                                            errorText = 'Please choose a file';
                                          });
                                        }
                                      });
                                    }),
                                    child: Text("Pick a file"),
                                  ),
                                ],
                              ),
                            ),  Column(
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
                                            child: CustomButton(
                                              onPressed: () async {
                                                String text =
                                                    await controller.getText();
                                                if (formKey.currentState
                                                    .validate()) {
                                                  if (fileContents == null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                     SnackBar(
                                          content:
                                              Text('Please select a file!'),
                                          backgroundColor: Colors.red,
                                        )
                                                    );
                                                  } else {
                                                    String response =
                                                        await addPostServices
                                                            .addNewPost(
                                                                titleController
                                                                    .text,
                                                                text.toString(),
                                                                snapshot
                                                                    .data.id,
                                                                snapshot.data
                                                                    .displayName,
                                                                snapshot.data
                                                                    .photoURL);
                                                    await FirebaseStorage
                                                        .instance
                                                        .ref(
                                                            'posts/$response/$fileName')
                                                        .putData(fileContents);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            postsNewWidget(),
                                                      ),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackbarWidget(
                                                        content: Text(
                                                          'Post added successfully!',
                                                        ),
                                                      ),
                                                    );
                                                  }
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

                  return Center(child: const CircularProgressIndicatorWidget(color: Colors.white,));
                })));
  }
}
