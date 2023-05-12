import '../../index.dart';
import '../all-posts/all-posts-model.dart';
import 'share-post-controller.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'share-post-model.dart';
import '../../user-profile/profile-controller.dart';
import 'package:flutter_html/flutter_html.dart';

class sharedPostsByUserWidget extends StatefulWidget {
  const sharedPostsByUserWidget({Key key}) : super(key: key);

  @override
  _sharedPostsByUserWidgetState createState() =>
      _sharedPostsByUserWidgetState();
}

class _sharedPostsByUserWidgetState extends State<sharedPostsByUserWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Post>> futurePost;
  ProfilingMan profilingUserServices = ProfilingMan();
  String _CurrentUserId;
  int number;
  sharedPostMan sharedPostsServices = sharedPostMan();

  Future<String> _getCurrentUserId() async {
    return profilingUserServices.GetIDCurrentUser();
  }

  void _getFutureStringValue() async {
    String value = await _getCurrentUserId();
    setState(() {
      _CurrentUserId = value;
    });
  }

  @override
  void initState() {
    super.initState();
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
        child: appbar(text: 'Posts'),
      ),
      drawer: Drawerr(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: FutureBuilder<List<sharedPost>>(
                    future:
                        sharedPostsServices.getAllSharedPostsByCurrentUserId(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) => Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(9, 8, 9, 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        FlutterAppTheme.of(context).whiteColor,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            2, 5, 2, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: FlutterAppTheme.of(context)
                                                  .tertiaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(1, 1, 1, 1),
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    '${snapshot.data[index].currentUserphoto}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
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
                                                                12, 0, 0, 0),
                                                    child: Text(
                                                      '${snapshot.data[index].currentUserName}',
                                                      style: FlutterAppTheme.of(
                                                              context)
                                                          .bodyText1,
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
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 12, 0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    FlutterAppTheme.of(context)
                                                        .whiteColor,
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                            child: Row(
                                                          children: [
                                                            Card(
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              color: FlutterAppTheme
                                                                      .of(context)
                                                                  .primaryColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            1,
                                                                            1,
                                                                            1,
                                                                            1),
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    '${snapshot.data[index].adminPhoto}',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '${snapshot.data[index].adminName}',
                                                                style: FlutterAppTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 4, 0, 4),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        '${snapshot.data[index].postPhoto}',
                                                        width: 350,
                                                        height: 300,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 5, 2, 5),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color: FlutterAppTheme.of(
                                                                        context)
                                                                    .Grey,
                                                                size: 24,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '2,493',
                                                                style: FlutterAppTheme.of(
                                                                        context)
                                                                    .bodyText2,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 5, 2, 0),
                                                      child: Html(
                                                          data: snapshot
                                                              .data[index]
                                                              .postContenu))
                                                ],
                                              ))),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        indent: 50,
                                        endIndent: 50,
                                      )
                                    ],
                                  ),
                                )));
                      } else if (snapshot.hasError) {
                        return Text('No shared posts with you',
                            textAlign: TextAlign.center,
                            style:
                                FlutterAppTheme.of(context).bodyText2.override(
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ));
                      }
                      return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 300, 0, 0),
                          child: const CircularProgressIndicatorWidget());
                    }))
          ],
        ),
      ),
    );
  }
}
