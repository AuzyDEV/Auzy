
import 'package:new_mee/common_widgets/app_bar.dart';
import 'package:new_mee/common_widgets/drawer.dart';
import 'package:new_mee/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:new_mee/models/Doctor.dart';

import '../../services/doctorsMan.dart';

class DoctorprofileWidget extends StatefulWidget {
  final String id;
  const DoctorprofileWidget({Key key, this.id}) : super(key: key);

  @override
  _DoctorprofileWidgetState createState() => _DoctorprofileWidgetState();
}

class _DoctorprofileWidgetState extends State<DoctorprofileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  Future<Doctor> _futureDoctor;
  DBDoctorMan apiDB = DBDoctorMan();

  @override
  void initState() {
    super.initState();
    _futureDoctor = apiDB.getDoctorDetails(widget.id);
    print(widget.id);
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
        child: appbar(text: 'doctor profile'),
      ),
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
              child: FutureBuilder<Doctor>(
                  future: _futureDoctor,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: FlutterAppTheme.of(context)
                                          .primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2, 2, 2, 2),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.network(
                                          '${snapshot.data.files[0].downloadURL}',
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${snapshot.data.firstName} ${snapshot.data.lastName}',
                                      style: FlutterAppTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF0F1113),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 2, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                        child: Text(
                                          '8 years exeriences',
                                          style: FlutterAppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Roboto',
                                                color:
                                                    FlutterAppTheme.of(context)
                                                        .primaryText,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 2, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${snapshot.data.speciality}',
                                        style: FlutterAppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterAppTheme.of(context)
                                                      .primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'About Doctor ',
                                  style: FlutterAppTheme.of(context)
                                      .subtitle1
                                      .override(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 2, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                    style: FlutterAppTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Roboto',
                                          color: FlutterAppTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Communication',
                                  style: FlutterAppTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF0F1113),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0x19A569BD),
                                      borderRadius: BorderRadius.circular(12),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Color(0xFFA569BD),
                                      size: 24,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Localisation',
                                        style: FlutterAppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterAppTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        '${snapshot.data.Adress}',
                                        style: FlutterAppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterAppTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFADBD8),
                                      borderRadius: BorderRadius.circular(12),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Icon(
                                      Icons.phone_rounded,
                                      color: FlutterAppTheme.of(context)
                                          .alternate,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Audio call',
                                        style: FlutterAppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterAppTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        '${snapshot.data.phoneNumber}',
                                        style: FlutterAppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterAppTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0x277ACEFA),
                                      borderRadius: BorderRadius.circular(12),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Icon(
                                      Icons.mail_rounded,
                                      color: Color(0xFF7ACEFA),
                                      size: 21,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'send mail',
                                        style: FlutterAppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterAppTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        '${snapshot.data.email}',
                                        style: FlutterAppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Roboto',
                                              color:
                                                  FlutterAppTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Reveiws',
                                      style: FlutterAppTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: Color(0xFF0F1113),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 2),
                                            child: Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFA130),
                                              size: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    2, 0, 0, 0),
                                            child: Text(
                                              '4.5',
                                              style: FlutterAppTheme.of(
                                                      context)
                                                  .subtitle1
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: Color(0xFF0F1113),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 0, 0),
                                            child: Text(
                                              '(124)',
                                              style:
                                                  FlutterAppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            FlutterAppTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                /* InkWell(
                        onTap: () async {
                          /*await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                  height: 500,
                                  child: AddreviewWidget(),
                                ),
                              );
                            },
                          ).then((value) => setState(() {}));*/
                        },
                        child: Text(
                          'add review',
                          style:
                              FlutterAppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Roboto',
                                    color: Color.fromARGB(255, 214, 116, 36),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                  */
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 8),
                                  child: Container(
                                    width: 270,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x320F1113),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2, 2, 2, 2),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 16, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 5, 0, 5),
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFE0E3E7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    2, 2, 2, 2),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.network(
                                                            'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDF8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                                                            width: 70,
                                                            height: 70,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 8, 0, 8),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'John Smith',
                                                            style: FlutterAppTheme
                                                                    .of(context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: Color(
                                                                      0xFF0F1113),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          Text(
                                                            '1 day ago',
                                                            style: FlutterAppTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterAppTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 12, 18),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 2),
                                                          child: Icon(
                                                            Icons.star_rounded,
                                                            color: Color(
                                                                0xFFFFA130),
                                                            size: 18,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(4,
                                                                      0, 0, 0),
                                                          child: Text(
                                                            '4.5',
                                                            style: FlutterAppTheme
                                                                    .of(context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: Color(
                                                                      0xFF0F1113),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 16, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
                                                      style:
                                                          FlutterAppTheme.of(
                                                                  context)
                                                              .bodyText2
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: Color(
                                                                    0xFF57636C),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(
                        child: const CircularProgressIndicator(
                      color: Color(0xFF9457FB),
                    ));
                  })),
        ),
      ),
    );
  }
}
