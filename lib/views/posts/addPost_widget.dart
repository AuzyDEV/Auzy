import 'dart:html';
import 'dart:typed_data';
//import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_mee/services/User_api.dart';
import 'package:new_mee/services/postMan.dart';
import 'package:new_mee/common_widgets/Button_widget.dart';
import 'package:new_mee/common_widgets/customized_AlertDialog.dart';
import 'package:new_mee/common_widgets/app_bar.dart';
import 'package:new_mee/common_widgets/drawer.dart';
import 'package:new_mee/views/home/home_widget.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/models/User.dart';
import 'package:new_mee/themes/theme.dart';
import 'package:new_mee/common_widgets/FFButtonWidget.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:html_editor_enhanced/html_editor.dart';

class addNewPostWidget extends StatefulWidget {
  const addNewPostWidget({Key key}) : super(key: key);

  @override
  _addNewPostWidgetState createState() => _addNewPostWidgetState();
}

class _addNewPostWidgetState extends State<addNewPostWidget> {
  TextEditingController titleController;
  TextEditingController TextController;
  // quill.QuillController _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  UserMan apiUser = UserMan();
  Future<User> _futureUser;
  PostMan apiPost = PostMan();
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
    // _controller = quill.QuillController.basic();
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
        backgroundColor: Colors.white,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 20, 16, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Title*',
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 10, 16, 0),
                                        child: TextFormField(
                                          controller: titleController,
                                          cursorColor: Color(0xFF9457FB),
                                          validator: (value) => value.isEmpty
                                              ? 'Field is required'
                                              : null,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            errorStyle:
                                                FlutterAppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Roboto',
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x988B97A2),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x988B97A2),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 12, 0),
                                          ),
                                          style: FlutterAppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 20, 16, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Text*',
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

                                /* Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 20, 16, 0),
                                  child: Column(
                                    children: [
                                      quill.QuillToolbar.basic(
                                          controller: _controller),
                                      Container(
                                        height: 200,
                                        child: quill.QuillEditor.basic(
                                          controller: _controller,
                                          readOnly:
                                              false, // true for view only mode
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(fileName),
                                    ElevatedButton(
                                      onPressed: (() {
                                        /*  print((_controller.document.toDelta())
                                            .toJson());*/
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
                                    /* if (fileContents != null)
                                      Text(
                                          "File contents: ${String.fromCharCodes(fileContents)}")*/
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              child: buttonWidget(
                                                onPressed: () async {
                                                  String text = await controller
                                                      .getText();
                                                  print(text);

                                                  if (formKey.currentState
                                                      .validate()) {
                                                    String response =
                                                        await apiPost.addNewPost(
                                                            titleController
                                                                .text,
                                                            text,
                                                            snapshot.data.id,
                                                            snapshot.data
                                                                .displayName,
                                                            snapshot
                                                                .data.photoURL);

                                                    await FirebaseStorage
                                                        .instance
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
                                                                child:
                                                                    Text("Ok"),
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
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return Center(
                      child: const CircularProgressIndicator(
                    color: Color(0xFF9457FB),
                  ));
                })));
  }
}
