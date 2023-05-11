import '../../../index.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';

import '../add-listing-category/add-listing-category-model.dart';
import '../all-listing-category/all-listing-category-for-admin.dart';
import '../edit-listing-category/edit-listing-category-view.dart';
import 'single-listing-category-controller.dart';

class SingleListingCategoryWidget extends StatefulWidget {
  final String id;
  const SingleListingCategoryWidget({Key key, this.id}) : super(key: key);

  @override
  _SingleListingCategoryWidgetState createState() =>
      _SingleListingCategoryWidgetState();
}

class _SingleListingCategoryWidgetState
    extends State<SingleListingCategoryWidget> {
  TextEditingController idtextController;
  TextEditingController fullnameController;
  bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SingleListingCategoryMan singleCategoryMan = SingleListingCategoryMan();
  Future<ListingCtegoryModel> _futureCategory;

  @override
  void initState() {
    super.initState();
    idtextController = TextEditingController();
    fullnameController = TextEditingController();
    _futureCategory = singleCategoryMan.getListingCategoryDetails(widget.id);
  }

  @override
  void dispose() {
    idtextController?.dispose();
    fullnameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Speciality details'),
      ),
      drawer: Drawerr(),
      body: SingleChildScrollView(
          child: FutureBuilder<ListingCtegoryModel>(
              future: _futureCategory,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: FlutterAppTheme.of(context).whiteColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                          "${snapshot.data.files[0].downloadURL}",
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 12),
                                  child: Text('Speciality',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: FlutterAppTheme.of(context)
                                              .TextColor)),
                                ),
                                TextFormFieldWidget(
                                  hintText: '${snapshot.data.Name}',
                                  readOnly: true,
                                ),
                                TextFormFieldWidget(
                                  hintText: '${snapshot.data.id}',
                                  readOnly: true,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                        color: Colors.green,
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  editListingCategoryWidget(
                                                      id: snapshot.data.id, name: snapshot.data.Name),
                                            ),
                                          );
                                        },
                                        text: 'update speciality',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                        color: Colors.red,
                                        onPressed: () async {
                                          var confirmDialogResponse =
                                              await showDialog<bool>(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return alertDialogWidget(
                                                        title:
                                                            'Delete Speciality',
                                                        content:
                                                            'Are you sure to delete this Speciality ?',
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    false),
                                                            child:
                                                                Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () => {
                                                              print(snapshot
                                                                  .data.id
                                                                  .toString()),
                                                              singleCategoryMan
                                                                  .deleteListingCategory(
                                                                      snapshot
                                                                          .data
                                                                          .id
                                                                          .toString()),
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ListingCategoryForAdmin(),
                                                                ),
                                                              ),
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackbarWidget(
                                                                          content:
                                                                              Text(
                                                                'Successfully Speciality deleted!',
                                                              ))),
                                                            },
                                                            child:
                                                                Text('Confirm'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ) ??
                                                  false;
                                        },
                                        text: 'Delete speciality',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicatorWidget());
              })),
    );
  }
}
