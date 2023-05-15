import 'package:skeleton/listing-directory/add-listing-category/add-listing-category-model.dart';
import 'package:skeleton/listing-directory/all-listing-category/all-listing-category-controller.dart';
import '../../../themes/theme.dart';
import '../../index.dart';
import 'package:flutter/material.dart';
import '../../user-profile/profile-controller.dart';

class ListingCategoryForAdmin extends StatefulWidget {
  const ListingCategoryForAdmin({Key key}) : super(key: key);

  @override
  _ListingCategoryForAdminState createState() =>
      _ListingCategoryForAdminState();
}

class _ListingCategoryForAdminState extends State<ListingCategoryForAdmin> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  String searchString = "";
  TextEditingController SearchtextController;
  Future<List<ListingCtegoryModel>> _futureCategory;
  ProfilingMan profilingUserServices = ProfilingMan();
  CategoryListingCtegoryMan categoryListingsServices =
      CategoryListingCtegoryMan();

  @override
  void initState() {
    super.initState();
    SearchtextController = TextEditingController();
    _futureCategory = categoryListingsServices.getAllListingCtegories();
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
        floatingActionButton: floatingActionButtonWidget(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => addListingCategoryWidget()),
            );
          },
          icon: Icons.add,
        ),
        drawer: Drawerr(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Health Professional\'s Specialities',
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
            Align(
              alignment: AlignmentDirectional(0.5, 6.41),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormFieldWidget(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                    hintText: "Search... ",
                    controller: SearchtextController,
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
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 3,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                if (snapshot.data[index].Name
                                    .toLowerCase()
                                    .contains(searchString))
                                  return InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SingleListingCategoryWidget(
                                            id: "${snapshot.data[index].id}",
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                  style: FlutterAppTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterAppTheme.of(
                                                                    context)
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
                                else
                                  return Container();
                              },
                            )));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("no data"),
                    );
                  }
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 280, 0, 0),
                    child: CircularProgressIndicatorWidget(),
                  );
                }),
          ],
        )));
  }
}
