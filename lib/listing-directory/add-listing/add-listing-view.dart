import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import '../../index.dart';
import '../../../themes/theme.dart';
import 'add-listing-controller.dart';
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
  DBDoctorMan listingServices = DBDoctorMan();
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
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      LabeledRowWidget(text: 'First Name'),
                      TextFormFieldWidget(
                        controller: firstNameController,
                        isRequired: true,
                        isString: true,
                      ),
                      LabeledRowWidget(text: 'Last Name'),
                      TextFormFieldWidget(
                        controller: lastNameController,
                        isRequired: true,
                        isString: true,
                      ),
                      LabeledRowWidget(text: 'Speciality'),
                      Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            child: ReusableDropdown(
                          items: specialties,
                          onChanged: (value) {
                            dropDownValue = value;
                          },
                        )),
                      ]),
                      LabeledRowWidget(text: 'Adress'),
                      TextFormFieldWidget(
                        controller: addressController,
                        maxLines: 2,
                        isRequired: true,
                      ),
                      LabeledRowWidget(text: 'Email'),
                      TextFormFieldWidget(
                        controller: emailController,
                        isRequired: true,
                        isEmail: true,
                      ),
                      LabeledRowWidget(text: 'Phone number'),
                      TextFormFieldWidget(
                        controller: phoneNumberController,
                        isRequired: true,
                        isNumeric: true,
                      ),
                      LabeledRowWidget(text: 'Select photo'),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                        child: Column(
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
                                child: CustomButton(
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      if (fileContents == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                       SnackBar(
                                          content:
                                              Text('Please select a file!'),
                                          backgroundColor: Colors.red,
                                        )
                                        );
                                      } else {
                                        String response =
                                            await listingServices.addNewListing(
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
          ],
        )));
  }
}
