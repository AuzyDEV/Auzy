import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import '../../services/doctorsMan.dart';
import '../../common_widgets/Button_widget.dart';
import '../../common_widgets/customized_AlertDialog.dart';
import '../../common_widgets/app_bar.dart';
import '../../common_widgets/drawer.dart';
import '../home/home_widget.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';

class addDoctorWidget extends StatefulWidget {
  const addDoctorWidget({Key key}) : super(key: key);

  @override
  _addDoctorWidgetState createState() => _addDoctorWidgetState();
}

class _addDoctorWidgetState extends State<addDoctorWidget> {
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
  String _dropdownError;
  Uint8List fileContents;
  static final RegExp emailReForInput = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  DBDoctorMan apiDBDoctor = DBDoctorMan();
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
          child: appbar(text: 'New doctor'),
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
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'First Name*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
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
                              controller: firstNameController,
                              validator: (value) =>
                                  value.isEmpty ? 'Filed is required' : null,
                              obscureText: false,
                              cursorColor: Color(0xFF9457FB),
                              decoration: InputDecoration(
                                errorStyle: FlutterAppTheme.of(context)
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                              ),
                              style: FlutterAppTheme.of(context)
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
                                  'Last Name*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
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
                              controller: lastNameController,
                              validator: (value) =>
                                  value.isEmpty ? 'Field is required' : null,
                              obscureText: false,
                              cursorColor: Color(0xFF9457FB),
                              decoration: InputDecoration(
                                errorStyle: FlutterAppTheme.of(context)
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                              ),
                              style: FlutterAppTheme.of(context)
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
                                  'Speciality*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
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
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
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
                                    ),
                                  ])),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Adress*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
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
                              maxLines: 2,
                              controller: addressController,
                              cursorColor: Color(0xFF9457FB),
                              validator: (value) =>
                                  value.isEmpty ? 'Field is required' : null,
                              obscureText: false,
                              decoration: InputDecoration(
                                errorStyle: FlutterAppTheme.of(context)
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                              ),
                              style: FlutterAppTheme.of(context)
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
                                  'Email*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
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
                              controller: emailController,
                              cursorColor: Color(0xFF9457FB),
                              validator: (value) => value.isEmpty
                                  ? 'Field is required'
                                  : (emailReForInput.hasMatch(value)
                                      ? null
                                      : 'Enter valid Email '),
                              obscureText: false,
                              decoration: InputDecoration(
                                errorStyle: FlutterAppTheme.of(context)
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                              ),
                              style: FlutterAppTheme.of(context)
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
                                  'Phone number*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
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
                              controller: phoneNumberController,
                              validator: (value) =>
                                  value.isEmpty ? 'Field is required' : null,
                              obscureText: false,
                              decoration: InputDecoration(
                                errorStyle: FlutterAppTheme.of(context)
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
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                              ),
                              style: FlutterAppTheme.of(context)
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
                                  'Select photo*',
                                  style: FlutterAppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: FlutterAppTheme.of(context)
                                            .TextColor,
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
                                /* if (fileContents != null)
                                      Text(
                                          "File contents: ${String.fromCharCodes(fileContents)}")*/
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
                                            await apiDBDoctor.addNewDoctor(
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
                                                    "Drug was added successfully",
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
