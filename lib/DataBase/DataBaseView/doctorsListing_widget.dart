import '../../CommonWidgets/Button.dart';
import '../../CommonWidgets/ButtonFloating.dart';
import '../../CommonWidgets/TextField.dart';
import '../DataBaseController/doctorsMan.dart';
import '../../CommonWidgets/AppBar.dart';
import '../../CommonWidgets/LeftDrawer.dart';
import 'addDoctor_widget.dart';
import 'doctorProfil_widget.dart';
import '../DataBaseModel/Doctor.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';

class listsdocWidget extends StatefulWidget {
  final String speciality;
  const listsdocWidget({Key key, this.speciality}) : super(key: key);

  @override
  _listsdocWidgetState createState() => _listsdocWidgetState();
}

class _listsdocWidgetState extends State<listsdocWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Doctor>> futureDoctor;
  DBDoctorMan apiDBDoctor = DBDoctorMan();
  String searchString = "";
  TextEditingController SearchtextController;
  String _futureRoleValue;

  Future<String> _getCurrentUserId() async {
    return apiUser.GetIDCurrentUser();
  }

  Future<String> _getCurrentUserRole() async {
    return apiUser.GetCurrentUserRole();
  }

  void _getFutureRoleValue() async {
    String value = await _getCurrentUserRole();
    setState(() {
      _futureRoleValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFutureRoleValue();
    futureDoctor = apiDBDoctor.getAllDoctorsWithSpeciality(widget.speciality);
    SearchtextController = TextEditingController();
    print(widget.speciality);
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
        child: appbar(text: 'Doctors'),
      ),
      floatingActionButton: _futureRoleValue == "admin"
          ? floatingActionButtonWidget(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addDoctorWidget()),
                );
              },
              icon: Icons.add,
            )
          : null,
      drawer: Drawerr(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0.5, 6.41),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: FlutterAppTheme.of(context).lightGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.search,
                                color: Color(0xFF9457FB),
                                size: 24,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 2),
                                  child: TextFormFieldWidget(
                                    onChanged: (value) {
                                      setState(() {
                                        searchString = value.toLowerCase();
                                      });
                                    },
                                    hintText: "Search for doctors",
                                    controller: SearchtextController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: FutureBuilder<List<Doctor>>(
                    future: futureDoctor,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder:
                                (_, index) =>
                                    ((snapshot.data[index].firstName
                                                .toLowerCase()
                                                .contains(searchString)) ||
                                            (snapshot.data[index].speciality
                                                .toLowerCase()
                                                .contains(searchString)) ||
                                            (snapshot.data[index].lastName
                                                .toLowerCase()
                                                .contains(searchString)))
                                        ? Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 8, 0),
                                                  child: Card(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    color: FlutterAppTheme.of(
                                                            context)
                                                        .whiteColor,
                                                    elevation: 1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          8),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
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
                                                                                      '${snapshot.data[index].files[0].downloadURL}',
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
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              8,
                                                                              1,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                '${snapshot.data[index].firstName} ${snapshot.data[index].lastName}',
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
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                3,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  '${snapshot.data[index].speciality}',
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
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            10,
                                                                            20,
                                                                            45),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => DoctorprofileWidget(id: snapshot.data[index].id)));
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.arrow_forward_ios_outlined,
                                                                            color:
                                                                                FlutterAppTheme.of(context).TextColor,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.85,
                                                              height: 1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFDBE2E7),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          8,
                                                                          0,
                                                                          8),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            2),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          'assets/images/2702604.png',
                                                                          width:
                                                                              20,
                                                                          height:
                                                                              20,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            '${snapshot.data[index].Adress}',
                                                                            style: FlutterAppTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Color(0xFF8B97A2),
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8,
                                                                            0,
                                                                            0,
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .local_phone,
                                                                          color:
                                                                              Colors.green,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              3,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            '${snapshot.data[index].phoneNumber}',
                                                                            style: FlutterAppTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Roboto',
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.normal,
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
                                          )
                                        : Container());
                      } else if (snapshot.hasError) {
                        return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                            child: Text('No doctors',
                                textAlign: TextAlign.center,
                                style: FlutterAppTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    )));
                      }
                      return const CircularProgressIndicator(
                        color: Color(0xFF9457FB),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
