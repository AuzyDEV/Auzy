import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_mee/listing-directory/add-listing-category/add-listing-category-controller.dart';
import 'package:new_mee/listing-directory/add-listing/add-listing-controller.dart';
import 'package:new_mee/themes/label-row.dart';
import 'package:new_mee/themes/text-field.dart';
import 'package:string_validator/string_validator.dart';
import '../../../themes/alert-popup.dart';
import '../../../themes/app-bar-widget.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/left-drawer.dart';
import '../../../themes/theme.dart';
import 'package:new_mee/home/home-view.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';

class addListingCategoryWidget extends StatefulWidget {
  const addListingCategoryWidget({Key key}) : super(key: key);

  @override
  _addListingCategoryWidgetState createState() =>
      _addListingCategoryWidgetState();
}

class _addListingCategoryWidgetState extends State<addListingCategoryWidget> {
  TextEditingController NameController;
  String fileName = "No file selected";
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  Uint8List fileContents;
  ListingCtegoryMan api = ListingCtegoryMan();
  @override
  void initState() {
    super.initState();
    NameController = TextEditingController();
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
          child: appbar(text: 'New Category'),
        ),
        drawer: Drawerr(),
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
                            child: LabeledRowWidget(text: 'Name'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: NameController,
                              isRequired: true,
                              isString: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Select photo'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
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
                                  child: Text("Pick an image"),
                                ),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: buttonWidget(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        String response =
                                            await api.addNewListingCategory(
                                          NameController.text,
                                        );

                                        await FirebaseStorage.instance
                                            .ref(
                                                'listingCategory/$response/$fileName')
                                            .putData(fileContents);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alertDialogWidget(
                                                title: "Succes!",
                                                content:
                                                    "category was added successfully",
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
                                    text: 'save',
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
        )));
  }
}
