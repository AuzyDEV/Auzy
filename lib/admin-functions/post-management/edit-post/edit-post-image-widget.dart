import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skeleton/admin-functions/post-management/edit-post/edit-post-controller.dart';
import 'package:skeleton/themes/theme.dart';
import 'package:flutter/material.dart';
import '../../../index.dart';

class updateImagePostWidget extends StatefulWidget {
  final String id, downloadURL;
  const updateImagePostWidget({Key key, this.id, this.downloadURL})
      : super(key: key);

  @override
  _updateImagePostWidgetState createState() => _updateImagePostWidgetState();
}

class _updateImagePostWidgetState extends State<updateImagePostWidget> {
  String fileName = "No file selected";

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  Uint8List fileContents;
  EditPostMan api = EditPostMan();
  @override
  void initState() {
    print(widget.id);
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
          child: appbar(text: 'Post\'s image'),
        ),
        drawer: Drawerr(),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                        child: Column(
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
                            /* if (fileContents != null)
                                      Text(
                                          "File contents: ${String.fromCharCodes(fileContents)}")*/
                          ],
                        ),
                      ),
                    ],
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
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      bool response = await api
                                          .deleteFilePostFromDownloadURL(
                                              widget.downloadURL);
                                      print(response);
                                      if (response == true) {
                                        await FirebaseStorage.instance
                                            .ref('posts/${widget.id}/$fileName')
                                            .putData(fileContents);
                                      }
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alertDialogWidget(
                                              title: "Succes!",
                                              content:
                                                  "post\'s image was updated successfully",
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
          ],
        )));
  }
}
