import '../../index.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'edit-listing-category-controller.dart';

class editListingCategoryWidget extends StatefulWidget {
  final String id, name;
  const editListingCategoryWidget({Key key, this.id, this.name})
      : super(key: key);

  @override
  _editListingCategoryWidgetState createState() =>
      _editListingCategoryWidgetState();
}

class _editListingCategoryWidgetState extends State<editListingCategoryWidget> {
  TextEditingController NameController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  EditSingleListingCategoryMan editListingCategoriesServives =
      EditSingleListingCategoryMan();
  @override
  void initState() {
    super.initState();
    NameController = TextEditingController();
    NameController.text = widget.name.toString();
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
          child: appbar(text: 'Edit Category'),
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
                        controller: NameController,
                        isRequired: true,
                        isString: true,
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
                                      bool response =
                                          await editListingCategoriesServives
                                              .editListingCategory(
                                        widget.id.toString(),
                                        NameController.text,
                                      );
                                      response == true
                                          ? showDialog(
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
                                              })
                                          : showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alertDialogWidget(
                                                  title: "Error!",
                                                  content: "$response",
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
          ],
        )));
  }
}
