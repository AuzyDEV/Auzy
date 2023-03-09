import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/apis/mailingMan.dart';
import 'package:new_mee/apis/postMan.dart';
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
import 'package:flutter_quill/flutter_quill.dart' as quill;

class addNewPostWidget extends StatefulWidget {
  const addNewPostWidget({Key key}) : super(key: key);

  @override
  _addNewPostWidgetState createState() => _addNewPostWidgetState();
}

class _addNewPostWidgetState extends State<addNewPostWidget> {
  TextEditingController titleController;
  TextEditingController TextController;
  quill.QuillController _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  UserMan apiUser = UserMan();
  Future<User> _futureUser;
  PostMan apiPost = PostMan();
  File _selectedFile;
  String fileName = "No file selected";
  Uint8List fileContents;
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
    _controller = quill.QuillController.basic();
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
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                          validator: (value) => value.isEmpty
                                              ? 'Enter post\'s title'
                                              : null,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Enter post\'s title...',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Roboto',
                                                      color: Color(0xFF9DA3A9),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF9DA3A9),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF9DA3A9),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 16, 20, 16),
                                          ),
                                          style: FlutterFlowTheme.of(context)
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
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(fileName),
                                    RaisedButton(
                                      onPressed: (() {
                                        print((_controller.document.toDelta())
                                            .toJson());
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
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  var contenu = _controller
                                                      .document
                                                      .toDelta()
                                                      .toJson();
                                                  print(_controller.document
                                                      .toPlainText());
                                                  if (formKey.currentState
                                                      .validate()) {
                                                    String response =
                                                        await apiPost.addNewPost(
                                                            titleController
                                                                .text,
                                                            contenu,
                                                            snapshot.data.id,
                                                            snapshot.data
                                                                .displayName,
                                                            snapshot
                                                                .data.photoURL);
                                                    print(response);
                                                    final metadata =
                                                        SettableMetadata(
                                                      //contentType: 'image/jpg',
                                                      customMetadata: {
                                                        'uid': response
                                                      },
                                                    );
                                                    await FirebaseStorage
                                                        .instance
                                                        .ref(
                                                            'posts/$response/$fileName')
                                                        .putData(fileContents);

                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title:
                                                                Text("Succes!"),
                                                            content: Text(
                                                                "Post was added successfully"),
                                                            actions: [
                                                              FlatButton(
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
                                                                              MenuWidget(),
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
                                                options: FFButtonOptions(
                                                  height: 45,
                                                  color: Color(0xff132137),
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBtnText,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return Center(child: const CircularProgressIndicator());
                })));
  }
}
