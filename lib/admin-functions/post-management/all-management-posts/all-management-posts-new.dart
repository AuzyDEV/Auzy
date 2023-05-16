import 'package:flutter_html/flutter_html.dart';
import '../../../index.dart';
import '../../../social-post/all-posts/all-posts-model.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import '../../../user-profile/profile-controller.dart';
import 'all-management-posts-controller.dart';

class postsNewWidget extends StatefulWidget {
  final String speciality;
  const postsNewWidget({Key key, this.speciality}) : super(key: key);

  @override
  _postsNewWidgetState createState() => _postsNewWidgetState();
}

class _postsNewWidgetState extends State<postsNewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Post>> futurePosts;
  PostMan postServices = PostMan();
  String searchString = "";
  TextEditingController SearchtextController;
  String _futureRoleValue;
  ProfilingMan apiUser = ProfilingMan();

  Future<String> _getCurrentUserRole() async {
    return apiUser.GetCurrentUserRole();
  }

  void _getFutureRoleValue() async {
    String value = await _getCurrentUserRole();
    setState(() {
      _futureRoleValue = value;
    });
  }

  Future<void> _refreshList() async {
    setState(() {
      futurePosts = postServices.getAllListingsNew();
    });
  }

  @override
  void initState() {
    super.initState();
    _getFutureRoleValue();
    futurePosts = postServices.getAllListingsNew();
    SearchtextController = TextEditingController();
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
        child: appbar(text: 'Post Management'),
      ),
      floatingActionButton: _futureRoleValue == "admin"
          ? floatingActionButtonWidget(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addNewPostWidget()),
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
                    hintText: "Search..",
                    controller: SearchtextController,
                  ),
                ],
              ),
            ),
            RefreshIndicator(
                onRefresh: _refreshList,
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: FutureBuilder<List<Post>>(
                        future: futurePosts,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (_, index) => ((snapshot
                                            .data[index].contenu
                                            .toLowerCase()
                                            .contains(searchString)) ||
                                        (snapshot.data[index].title
                                            .toLowerCase()
                                            .contains(searchString)))
                                    ? Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 8, 16, 8),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color:
                                                            FlutterAppTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(1,
                                                                      1, 1, 1),
                                                          child: Container(
                                                            width: 40,
                                                            height: 40,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Image.asset(
                                                              "../../assets/images/user.png",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(12, 0,
                                                                    0, 0),
                                                        child: Text(
                                                          '${snapshot.data[index].uname}',
                                                          style: FlutterAppTheme
                                                                  .of(context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 4),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  '${snapshot.data[index].files[0].downloadURL}',
                                                  width: 350,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5, 2, 5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Row(children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                postDetailsWidget(
                                                                    id: snapshot
                                                                        .data[
                                                                            index]
                                                                        .id
                                                                        .toString()),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 40,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.blue[50],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(4,
                                                                      4, 4, 4),
                                                          child: Icon(
                                                            Icons
                                                                .remove_red_eye_outlined,
                                                            color: Colors.blue,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 0, 0),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          var confirmDialogResponse =
                                                              await showDialog<
                                                                      bool>(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return alertDialogWidget(
                                                                        title:
                                                                            'Delete post',
                                                                        content:
                                                                            'Are you sure to delete this post ?',
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, false),
                                                                            child:
                                                                                Text('Cancel'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                {
                                                                              postServices.deletePost(snapshot.data[index].id.toString()),
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => postsNewWidget(),
                                                                                ),
                                                                              ),
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackbarWidget(
                                                                                  content: Text(
                                                                                    'Successfully post deleted!',
                                                                                  ),
                                                                                ),
                                                                              ),
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
                                                        child: Container(
                                                          width: 40,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    245,
                                                                    210,
                                                                    207),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4,
                                                                        4,
                                                                        4,
                                                                        4),
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      163,
                                                                      32,
                                                                      23),
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 0, 0),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  editPostDetailsWidget(
                                                                id: snapshot
                                                                    .data[index]
                                                                    .id
                                                                    .toString(),
                                                                title: snapshot
                                                                    .data[index]
                                                                    .title,
                                                                contenu: snapshot
                                                                    .data[index]
                                                                    .contenu,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    214,
                                                                    241,
                                                                    228,
                                                                    200),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4,
                                                                        4,
                                                                        4,
                                                                        4),
                                                            child: Icon(
                                                              Icons.update,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      214,
                                                                      116,
                                                                      36),
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    snapshot.data[index]
                                                                .visibility
                                                                .toString() ==
                                                            "true"
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                var confirmDialogResponse =
                                                                    await showDialog<
                                                                            bool>(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return alertDialogWidget(
                                                                              title: 'Hide post',
                                                                              content: 'Are you sure to hide this post ?',
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                  child: Text('Cancel'),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () => {
                                                                                    postServices.HidePost(snapshot.data[index].id.toString()),
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => HomeWidget(),
                                                                                      ),
                                                                                    ),
                                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackbarWidget(
                                                                                      content: Text(
                                                                                        'Successfully post hide!',
                                                                                      ),
                                                                                    )),
                                                                                  },
                                                                                  child: Text('Confirm'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        ) ??
                                                                        false;
                                                              },
                                                              child: Container(
                                                                width: 40,
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red[100],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4,
                                                                          4,
                                                                          4,
                                                                          4),
                                                                  child: Icon(
                                                                    Icons
                                                                        .lock_outline,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                var confirmDialogResponse =
                                                                    await showDialog<
                                                                            bool>(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return alertDialogWidget(
                                                                              title: 'restore post',
                                                                              content: 'Are you sure to restore this post ?',
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                  child: Text('Cancel'),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () => {
                                                                                    postServices.RestorePost(snapshot.data[index].id.toString()),
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                        builder: (context) => HomeWidget(),
                                                                                      ),
                                                                                    ),
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackbarWidget(
                                                                                        content: Text(
                                                                                          'Successfully post restored!',
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  },
                                                                                  child: Text('Confirm'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        ) ??
                                                                        false;
                                                              },
                                                              child: Container(
                                                                width: 40,
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .green[50],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .green[50],
                                                                    width: 0,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4,
                                                                          4,
                                                                          4,
                                                                          4),
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove_red_eye_outlined,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                  ])),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5, 2, 0),
                                              child: Html(
                                                  data:
                                                      "${snapshot.data[index].contenu}",
                                                  style: {
                                                    '#': Style(
                                                      maxLines: 3,
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  }),
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    child: Text(
                                                      "See all",
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      /* Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(builder: (context) => postDetailsWidget(id: snapshot.data[index].id)),
                                                                                    );*/
                                                    },
                                                  ),
                                                ]),
                                            Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 12, 2, 12),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${snapshot.data[index].date}',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ))
                                    : Container());
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                            /* Padding(
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
                                        )));*/
                          }
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 280, 0, 0),
                            child: CircularProgressIndicatorWidget(),
                          );
                        }))),
          ],
        ),
      ),
    );
  }
}
