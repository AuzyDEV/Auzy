import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../index.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import '../themes/custom-button.dart';
import 'contact-us-controller.dart';

class contactUsWidget extends StatefulWidget {
  const contactUsWidget({Key key}) : super(key: key);

  @override
  _contactUsWidgetState createState() => _contactUsWidgetState();
}

class _contactUsWidgetState extends State<contactUsWidget> {
  TextEditingController emailAddressController;
  TextEditingController fullnameController;
  TextEditingController messageController;
  final TextEditingController mobilecontroller = TextEditingController();
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final formKey = GlobalKey<FormState>();
  EmailMan Maillingapi = EmailMan();
  bool switchListTileValue;
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    fullnameController = TextEditingController();
    messageController = TextEditingController();
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
        child: appbar(text: 'Contact us'),
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
                    LabeledRowWidget(text: 'Name'),
                    TextFormFieldWidget(
                      controller: fullnameController,
                      isRequired: true,
                      isString: true,
                    ),
                    LabeledRowWidget(text: 'Email'),
                    TextFormFieldWidget(
                      controller: emailAddressController,
                      isRequired: true,
                      isEmail: true,
                    ),
                    LabeledRowWidget(text: 'Mobile'),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        cursorColor: Color(0xFF9457FB),
                        validator: (value) =>
                            value.isEmpty ? 'Field is required' : null,
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: mobilecontroller,
                        formatInput: true,
                        inputBorder: OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {},
                      ),
                    ),
                    LabeledRowWidget(text: 'Message'),
                    TextFormFieldWidget(
                      controller: messageController,
                      isRequired: true,
                      maxLines: 8,
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: CustomButton(
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    bool response =
                                        await Maillingapi.ContactUsWithEmail(
                                            emailAddressController.text,
                                            fullnameController.text,
                                            mobilecontroller.text,
                                            messageController.text);
                                    print(response);
                                    response == true
                                        ? showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alertDialogWidget(
                                                title: "Succes!",
                                                content:
                                                    "Email was sent successfully",
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
                                            })
                                        : showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alertDialogWidget(
                                                title: "Error!",
                                                content: "$response",
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
      )),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }
}
