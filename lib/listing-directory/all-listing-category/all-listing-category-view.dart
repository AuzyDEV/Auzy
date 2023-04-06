import 'package:new_mee/listing-directory/add-listing-category/add-listing-category-controller.dart';
import 'package:new_mee/listing-directory/add-listing-category/add-listing-category-model.dart';
import 'package:new_mee/listing-directory/add-listing-category/add-listing-category-view.dart';
import 'package:new_mee/listing-directory/all-listing-category/all-listing-category-controller.dart';
import 'package:new_mee/listing-directory/all-listings/all-listings-view.dart';

import '../../../themes/app-bar-widget.dart';
import '../../../themes/left-drawer.dart';
import '../../../themes/theme.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';

class SpecialitiesWidget extends StatefulWidget {
  const SpecialitiesWidget({Key key}) : super(key: key);

  @override
  _SpecialitiesWidgetState createState() => _SpecialitiesWidgetState();
}

class _SpecialitiesWidgetState extends State<SpecialitiesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  Future<List<ListingCtegoryModel>> _futureCategory;
  CategoryListingCtegoryMan api = CategoryListingCtegoryMan();
  @override
  void initState() {
    super.initState();
    _futureCategory = api.getAllListingCtegories();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterAppTheme.of(context).primaryBtnText,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appbar(text: 'Categories'),
        ),
        drawer: Drawerr(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Health Professional\'s \nSpecialities',
                        style: FlutterAppTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<List<ListingCtegoryModel>>(
                future: _futureCategory,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Align(
                        alignment: AlignmentDirectional(0.05, 0),
                        child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: GridView.builder(
                              itemCount: snapshot.data.length,
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 0,
                                childAspectRatio: 0.7,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllListingsWidget(
                                          speciality:
                                              "${snapshot.data[index].Name}",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 75,
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF1F4F8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              '${snapshot.data[index].files[0].downloadURL}',
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${snapshot.data[index].Name}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterAppTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterAppTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("no data"),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        )));
  }
}
