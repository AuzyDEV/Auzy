import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:new_mee/themes/custom-dropdown-field.dart';
import 'package:new_mee/themes/dropdown-field.dart';
import 'package:new_mee/themes/label-row.dart';
import 'package:new_mee/themes/text-field.dart';
import 'package:string_validator/string_validator.dart';
import '../../../themes/alert-popup.dart';
import '../../../themes/app-bar-widget.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/left-drawer.dart';
import '../../../themes/theme.dart';
import 'add-listing-controller.dart';
import 'package:new_mee/home/home-view.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';

class addListingWidget extends StatefulWidget {
  const addListingWidget({Key key}) : super(key: key);

  @override
  _addListingWidgetState createState() => _addListingWidgetState();
}

class _addListingWidgetState extends State<addListingWidget> {
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController phoneNumberController;
  TextEditingController addressController;
  String fileName = "No file selected";
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String dropDownValue;
  Uint8List fileContents;
  DBDoctorMan apiDBDoctor = DBDoctorMan();
  List<String> specialties = [
    "Neurologist",
    "Psychiatrist",
    "Family physician",
    "Pediatrician",
    "Child psychiatrist",
    "Occupational therapist",
    "Ophtalmologist",
    "Orthopdist",
    "Physical therapist",
    "Otorhinolaryngologist",
    "Psychotherapist",
    "Psychomotor therapist",
    "Psychologist",
    "speech and language therapist",
  ];

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
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
          child: appbar(text: 'New Listing'),
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
                            child: LabeledRowWidget(text: 'First Name'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: firstNameController,
                              isRequired: true,
                              isString: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Last Name'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: lastNameController,
                              isRequired: true,
                              isString: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Speciality'),
                          ),
                          Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        child: ReusableDropdown(
                                      items: specialties,
                                      onChanged: (value) {
                                        dropDownValue = value;
                                      },
                                    )
                                        /*     child: DropdownButtonFormField<String>(
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: "Neurologist",
                                            child: Text(
                                              "Neurologist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Psychiatrist",
                                            child: Text(
                                              "Psychiatrist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Familyphysician",
                                            child: Text(
                                              "Familyphysician",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Pediatrician",
                                            child: Text(
                                              "Pediatrician",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Childpsychiatrist",
                                            child: Text(
                                              "Childpsychiatrist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Occupationaltherapist",
                                            child: Text(
                                              "Occupationaltherapist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Ophtalmologist",
                                            child: Text(
                                              "Ophtalmologist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Orthopdist",
                                            child: Text(
                                              "Orthopdist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Physicaltherapist",
                                            child: Text(
                                              "Physicaltherapist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Otorhinolaryngologist",
                                            child: Text(
                                              "Otorhinolaryngologist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Psychotherapist",
                                            child: Text(
                                              "Psychotherapist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Psychomotortherapist",
                                            child: Text(
                                              "Psychomotortherapist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "Psychologist",
                                            child: Text(
                                              "Psychologist",
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "speechandlanguagetherapist",
                                            child: Text(
                                              "speechandlanguagetherapist",
                                            ),
                                          ),
                                        ],
                                        onChanged: (val) {
                                          setState(() {
                                            dropDownValue = val;
                                            _dropdownError = null;
                                          });
                                          _dropdownError == null
                                              ? SizedBox.shrink()
                                              : Text(
                                                  _dropdownError ?? "",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                );
                                        },
                                        validator: (value) => value == null
                                            ? 'Field is required'
                                            : null,
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
                                        elevation: 2,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        isDense: true,
                                        iconSize: 18.0,
                                        iconEnabledColor: Colors.grey,
                                      ),
                                 */
                                        ),
                                  ])),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Adress'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: addressController,
                              maxLines: 2,
                              isRequired: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Email'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: emailController,
                              isRequired: true,
                              isEmail: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Phone number'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: phoneNumberController,
                              isRequired: true,
                              isNumeric: true,
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
                                            await apiDBDoctor.addNewListing(
                                                firstNameController.text,
                                                lastNameController.text,
                                                dropDownValue,
                                                emailController.text,
                                                phoneNumberController.text,
                                                addressController.text);

                                        await FirebaseStorage.instance
                                            .ref('doctors/$response/$fileName')
                                            .putData(fileContents);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alertDialogWidget(
                                                title: "Succes!",
                                                content:
                                                    "Doctor was added successfully",
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
        )));
  }
}
