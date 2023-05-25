import '../../index.dart';
import '../../user-profile/profile-controller.dart';
import 'single-listing-controller.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'single-listing-model.dart';

class DoctorprofileWidget extends StatefulWidget {
  final String id;
  const DoctorprofileWidget({Key key, this.id}) : super(key: key);

  @override
  _DoctorprofileWidgetState createState() => _DoctorprofileWidgetState();
}

class _DoctorprofileWidgetState extends State<DoctorprofileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  Future<ListingModel> _futureDoctor;

  SingleListingMan singleListingServices = SingleListingMan();
  String _futureRoleValue;
  ProfilingMan profilingMan = ProfilingMan();

  Future<String> _getCurrentUserRole() async {
    return profilingMan.GetCurrentUserRole();
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
    _futureDoctor = singleListingServices.getListingDetails(widget.id);
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
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Professional Details'),
      ),
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: FutureBuilder<ListingModel>(
              future: _futureDoctor,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB( 0, 5, 0, 5),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: FlutterAppTheme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
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
                        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
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
                                  style: FlutterAppTheme.of(context).title3.override(
                                    fontFamily: 'Roboto',
                                    color: FlutterAppTheme.of(context).TextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB( 0, 2, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${snapshot.data.speciality}',
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      color: FlutterAppTheme.of(context).primaryColor,
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
                        padding:  EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('About Doctor ',
                              style: FlutterAppTheme.of(context).subtitle1.override(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 2, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: FlutterAppTheme.of(context).bodyText2.override(
                                  fontFamily: 'Roboto',
                                  color: FlutterAppTheme.of(context).secondaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Communication',
                              style: FlutterAppTheme.of(context).subtitle2.override(
                                fontFamily: 'Roboto',
                                color: FlutterAppTheme.of(context).TextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Localisation',
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      color: FlutterAppTheme.of(context).secondaryText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text('${snapshot.data.Adress}',
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      color: FlutterAppTheme.of(context).secondaryText,
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
                        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                                  color: FlutterAppTheme.of(context).alternate,
                                  size: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB( 15, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('Audio call',
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      color: FlutterAppTheme.of(context).secondaryText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text('${snapshot.data.phoneNumber}',
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      color: FlutterAppTheme.of(context).secondaryText,
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
                        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('send mail',
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      color: FlutterAppTheme.of(context).secondaryText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text('${snapshot.data.email}',
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      color: FlutterAppTheme.of(context).secondaryText,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      _futureRoleValue == "admin" ?
                        CustomButton(
                          onPressed: () async {
                            var confirmDialogResponse = await showDialog<bool>(
                              context: context,
                              builder: (alertDialogContext) {
                                return alertDialogWidget(
                                  title: 'Delete Doctor',
                                  content:'Are you sure to delete this Doctor ?',
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop( alertDialogContext, false),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => {
                                        singleListingServices.deleteListing(snapshot.data.id.toString()),
                                        Navigator.push(context,
                                          MaterialPageRoute(
                                            builder: (context) => AllListingsWidget(),
                                          ),
                                        ),
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackbarWidget(
                                            content: Text('Successfully Doctor deleted!',
                                            )
                                          )
                                        ),
                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                          false;
                          },
                          text: 'Delete doctor',
                        )
                      : Container()
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 280, 0, 0),
                  child: CircularProgressIndicatorWidget(),
                );
              }
            )
          ),
        ),
      ),
    );
  }
}
