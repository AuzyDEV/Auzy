import 'dart:convert';

import 'package:skeleton/listing-directory/add-listing-category/add-listing-category-model.dart';
import 'package:skeleton/listing-directory/all-listing-category/all-listing-category-controller.dart';
import '../../../themes/theme.dart';
import '../../index.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../user-profile/profile-controller.dart';
import '../single-listing/single-listing-model.dart';

class SpecialitiesWidget extends StatefulWidget {
  const SpecialitiesWidget({Key key}) : super(key: key);

  @override
  _SpecialitiesWidgetState createState() => _SpecialitiesWidgetState();
}

class _SpecialitiesWidgetState extends State<SpecialitiesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  String searchString = "";
  TextEditingController SearchtextController;
  Future<List<ListingCtegoryModel>> _futureCategory;
  ProfilingMan profilingUserServices = ProfilingMan();
  CategoryListingCtegoryMan categoryListingsServices = CategoryListingCtegoryMan();
  List<ListingCtegoryModel> items = []; 
 ListingCtegoryModel selectedValue;
 List<ListingModel> doctors = [];
  List<ListingModel> filteredDoctors = [];

  Future<void> fetchListingCategory() async {
    String collectionName = "listingCategory";
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/DBB/${collectionName}'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        items = jsonData.map((item) => ListingCtegoryModel.fromMapName(item)).toList();
      });
    } else {
      throw Exception('Failed to fetch items');
    }
  }
  
  Future<void> fetchDoctors() async {
    String collectionName = "doctors";
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    if (response.statusCode == 200) {
      final  listingCategories = json.decode(response.body);
      final listCategory = listingCategories["message"]["listCollections"];
      setState(() {
        doctors = listCategory.map<ListingModel>((json) => ListingModel.fromMap(json)).toList();
        filteredDoctors = doctors;
      });
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  void filterDoctors(ListingCtegoryModel speciality) {
    setState(() {
      selectedValue = speciality;
      if (speciality != null) {
        filteredDoctors = doctors.where((doctor) => doctor.speciality == speciality.Name).toList();
      } else {
        filteredDoctors = doctors;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchListingCategory();
    fetchDoctors();
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Professionals'),
      ),
      drawer: Drawerr(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find a professional',
                        style: FlutterAppTheme.of(context).bodyText1.override(
                          color: FlutterAppTheme.of(context).ButtonPrimaryColor,
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: DropdownButtonFormField<ListingCtegoryModel>(
                    value: selectedValue,
                    onChanged: (ListingCtegoryModel newValue) {
                      setState(() {
                        selectedValue = newValue;
                        filterDoctors(newValue);
                      });
                    },
                    items: items.map<DropdownMenuItem<ListingCtegoryModel>>((ListingCtegoryModel item) {
                      return DropdownMenuItem<ListingCtegoryModel>(
                        value: item,
                        child: Text(item.Name),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: "Search for doctors ... ",
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: FlutterAppTheme.of(context).bodyText1.override(
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
                      contentPadding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    ),
                    dropdownColor: Colors.white,
                      elevation: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      isDense: true,
                      iconSize: 18.0,
                      iconEnabledColor: Colors.grey,
                    ),    
                  ),            
                ],
              ),
            ),
            SizedBox(
              height: 200, 
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: FlutterAppTheme.of(context).whiteColor,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB( 0, 8, 0,8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB( 12, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          color: FlutterAppTheme.of(context).primaryColor,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(60),
                                                            child: Image.network(
                                                              '${filteredDoctors[index].files[0].downloadURL}',
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(8, 1, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        '${filteredDoctors[index].firstName} ${filteredDoctors[index].lastName}',
                                                        style: FlutterAppTheme.of(context).subtitle1.override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterAppTheme.of(context).TextColor,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          '${filteredDoctors[index].speciality}',
                                                          style: FlutterAppTheme.of(context).bodyText2.override(
                                                            fontFamily: 'Roboto',
                                                            color: FlutterAppTheme.of(context).TextColor,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 45),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorprofileWidget(id: filteredDoctors[index].id)));
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_forward_ios_outlined,
                                                    color: FlutterAppTheme.of(context).TextColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.85,
                                      height: 1,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFDBE2E7),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB( 16, 8, 0, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Image.asset(
                                                  'assets/images/2702604.png',
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit.cover,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    '${filteredDoctors[index].Adress}',
                                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Roboto',
                                                      color: FlutterAppTheme.of(context).TextColor,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB( 8, 0, 0, 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.local_phone,
                                                  color: Colors.green,
                                                  size: 15,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                                                  child: Text(
                                                    '${filteredDoctors[index].phoneNumber}',
                                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Roboto',
                                                      color: FlutterAppTheme.of(context).TextColor,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ), 
          ],
        )
      )
    );
  }
}
