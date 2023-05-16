import '../../index.dart';
import '../../user-profile/profile-controller.dart';
import '../../../themes/theme.dart';
import 'all-posts-controller.dart';
import '../all-saved-posts/all-saved-posts-controller.dart';
import '../share-post/share-post-controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'all-posts-model.dart';
import '../all-saved-posts/all-saved-posts-model.dart';
import '../share-post/share-post-model.dart';
import 'package:flutter_html/flutter_html.dart';

class postsForUsersWidget extends StatefulWidget {
  const postsForUsersWidget({Key key}) : super(key: key);

  @override
  _postsForUsersWidgetState createState() => _postsForUsersWidgetState();
}

class _postsForUsersWidgetState extends State<postsForUsersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Post>> futurePost;
  PostsUserMan postsServices = PostsUserMan();
  ProfilingMan profilingUserServices = ProfilingMan();
  String _CurrentUserId;
  Future<List<savedPost>> futureSavedPost;
  SavedPostMan savedPostsServices = SavedPostMan();
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
    _getFutureStringValue();

    futurePost = postsServices.getAllPostsForUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Posts'),
      ),
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelColor: FlutterAppTheme.of(context).primaryColor,
                        unselectedLabelColor:
                            FlutterAppTheme.of(context).primaryText,
                        labelStyle: GoogleFonts.getFont(
                          'Roboto',
                        ),
                        indicatorColor:
                            FlutterAppTheme.of(context).primaryColor,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            text: 'All Posts',
                          ),
                          Tab(
                            text: 'Saved Posts',
                          ),
                          Tab(
                            text: "Shared Posts",
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 0, 8, 0),
                                                child:
                                                    FutureBuilder<List<Post>>(
                                                        future: futurePost,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return ListView
                                                                .builder(
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  snapshot.data
                                                                      .length,
                                                              itemBuilder: (_,
                                                                      index) =>
                                                                  Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              16,
                                                                              8,
                                                                              16,
                                                                              8),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Expanded(
                                                                                    child: Row(
                                                                                  children: [
                                                                                    Card(
                                                                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                      color: FlutterAppTheme.of(context).primaryColor,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
                                                                                        child: Container(
                                                                                          width: 40,
                                                                                          height: 40,
                                                                                          clipBehavior: Clip.antiAlias,
                                                                                          decoration: BoxDecoration(
                                                                                            shape: BoxShape.circle,
                                                                                          ),
                                                                                          child: Image.asset(
                                                                                            "../../assets/images/user.png",
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                      child: Text(
                                                                                        '${snapshot.data[index].uname}',
                                                                                        style: FlutterAppTheme.of(context).bodyText1,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                                snapshot.data[index].existsInCollection2 == "false"
                                                                                    ? Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                        child: FlutterFlowIconButton(
                                                                                          borderColor: Colors.transparent,
                                                                                          borderRadius: 30,
                                                                                          buttonSize: 46,
                                                                                          icon: Icon(
                                                                                            Icons.bookmark_outline_outlined,
                                                                                            color: FlutterAppTheme.of(context).secondaryText,
                                                                                            size: 23,
                                                                                          ),
                                                                                          onPressed: () async {
                                                                                            bool response = await savedPostsServices.SavePost(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].contenu, snapshot.data[index].date, snapshot.data[index].uname, snapshot.data[index].uphoto, _CurrentUserId);
                                                                                            await Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) => postsForUsersWidget(),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      )
                                                                                    : Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                        child: FlutterFlowIconButton(
                                                                                          borderColor: Colors.transparent,
                                                                                          borderRadius: 30,
                                                                                          buttonSize: 46,
                                                                                          icon: Icon(
                                                                                            Icons.bookmark_outlined,
                                                                                            color: Colors.amber,
                                                                                            size: 23,
                                                                                          ),
                                                                                          onPressed: () async {},
                                                                                        ),
                                                                                      )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                4,
                                                                                0,
                                                                                4),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              child: Image.network(
                                                                                '${snapshot.data[index].downloadURL}',
                                                                                width: 350,
                                                                                height: 300,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                5,
                                                                                2,
                                                                                5),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                    child: Row(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                                                      child: Icon(
                                                                                        Icons.favorite_border_outlined,
                                                                                        color: FlutterAppTheme.of(context).secondaryText,
                                                                                        size: 24,
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                                                      child: Text(
                                                                                        '2,493',
                                                                                        style: FlutterAppTheme.of(context).bodyText2,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                                                  child: InkWell(
                                                                                    onTap: () async {
                                                                                      await Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(builder: (context) => UsersListForPostsWidget(postId: snapshot.data[index].id, Postcontenu: snapshot.data[index].contenu, postImage: snapshot.data[index].downloadURL, CurrentuserId: _CurrentUserId, adminName: snapshot.data[index].uname, adminPhoto: snapshot.data[index].uphoto)),
                                                                                      );
                                                                                    },
                                                                                    child: Icon(
                                                                                      Icons.ios_share_sharp,
                                                                                      color: FlutterAppTheme.of(context).secondaryText,
                                                                                      size: 23,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                5,
                                                                                2,
                                                                                0),
                                                                            child:
                                                                                Html(data: snapshot.data[index].contenu, style: {
                                                                              '#': Style(
                                                                                maxLines: 3,
                                                                                textOverflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            }),
                                                                          ),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  child: Text(
                                                                                    "Read more",
                                                                                    style: TextStyle(
                                                                                      color: Colors.blue,
                                                                                      decoration: TextDecoration.underline,
                                                                                    ),
                                                                                  ),
                                                                                  onTap: () {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(builder: (context) => postDetailsWidget(id: snapshot.data[index].id)),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ]),
                                                                          Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 2, 12),
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      '${snapshot.data[index].date}',
                                                                                      textAlign: TextAlign.right,
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )),
                                                                        ],
                                                                      )),
                                                            );
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'There is no posts',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterAppTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      color: FlutterAppTheme.of(
                                                                              context)
                                                                          .LightDarkTextColor,
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ));
                                                          }
                                                          return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          280,
                                                                          0,
                                                                          0),
                                                              child:
                                                                  const CircularProgressIndicatorWidget());
                                                        }))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 8, 0),
                                                  child: FutureBuilder<
                                                          List<savedPost>>(
                                                      future: savedPostsServices
                                                          .getAllSavedPostsForUsers(
                                                              _CurrentUserId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return ListView
                                                              .builder(
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data.length,
                                                            itemBuilder: (_,
                                                                    index) =>
                                                                Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            8,
                                                                            16,
                                                                            8),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              2,
                                                                              0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Card(
                                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                color: FlutterAppTheme.of(context).primaryColor,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
                                                                                  child: Container(
                                                                                    width: 40,
                                                                                    height: 40,
                                                                                    clipBehavior: Clip.antiAlias,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Image.asset(
                                                                                      "../../assets/images/user.png",
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                      child: Text(
                                                                                        '${snapshot.data[index].uname}',
                                                                                        style: FlutterAppTheme.of(context).bodyText1,
                                                                                      ),
                                                                                    ),
                                                                                    FlutterFlowIconButton(
                                                                                      borderColor: Colors.transparent,
                                                                                      borderRadius: 30,
                                                                                      buttonSize: 46,
                                                                                      icon: Icon(
                                                                                        Icons.bookmark,
                                                                                        color: Colors.amber,
                                                                                        size: 23,
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        bool response = await savedPostsServices.DeleteSavedPost(snapshot.data[index].id);
                                                                                        if (response == true)
                                                                                          Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                              builder: (context) => postsForUsersWidget(),
                                                                                            ),
                                                                                          );
                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                          SnackbarWidget(
                                                                                              content: Text(
                                                                                            'Successfully saved post deleted!',
                                                                                          )),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              4,
                                                                              0,
                                                                              4),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            child:
                                                                                Image.network(
                                                                              '${snapshot.data[index].files[0].downloadURL}',
                                                                              width: 350,
                                                                              height: 300,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              5,
                                                                              2,
                                                                              0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                                                child: Text(
                                                                                  '2,493',
                                                                                  style: FlutterAppTheme.of(context).bodyText2,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              5,
                                                                              2,
                                                                              0),
                                                                          child:
                                                                              Html(data: snapshot.data[index].postContenu),
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              GestureDetector(
                                                                                child: Text(
                                                                                  "Read more",
                                                                                  style: TextStyle(
                                                                                    color: Colors.blue,
                                                                                    decoration: TextDecoration.underline,
                                                                                  ),
                                                                                ),
                                                                                onTap: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(builder: (context) => postDetailsWidget(id: snapshot.data[index].id)),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ]),
                                                                      ],
                                                                    )),
                                                          );
                                                        } else if (snapshot
                                                            .hasError) {
                                                          return Text(
                                                              'There is no saved posts',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterAppTheme
                                                                      .of(context)
                                                                  .bodyText2
                                                                  .override(
                                                                    color: FlutterAppTheme.of(
                                                                            context)
                                                                        .LightDarkTextColor,
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ));
                                                        }
                                                        return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        280,
                                                                        0,
                                                                        0),
                                                            child:
                                                                const CircularProgressIndicatorWidget());
                                                      }))),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 0, 8, 0),
                                                child: FutureBuilder<
                                                        List<sharedPost>>(
                                                    future: sharedPostsServices
                                                        .getAllSharedPostsByCurrentUserId(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data.length,
                                                            itemBuilder: (_,
                                                                    index) =>
                                                                Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            9,
                                                                            8,
                                                                            9,
                                                                            8),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: FlutterAppTheme.of(context)
                                                                            .whiteColor,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                2,
                                                                                5,
                                                                                2,
                                                                                8),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Card(
                                                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                  color: FlutterAppTheme.of(context).tertiaryColor,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
                                                                                    child: Container(
                                                                                      width: 40,
                                                                                      height: 40,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Image.asset(
                                                                                        "../../assets/images/user.png",
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                        child: Text(
                                                                                          '${snapshot.data[index].currentUserName}',
                                                                                          style: FlutterAppTheme.of(context).bodyText1,
                                                                                        ),
                                                                                      ),
                                                                                      InkWell(
                                                                                          onTap: () async {
                                                                                            await Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) => ProfillWidget(id: snapshot.data[index].currentUserId),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.more_vert_outlined,
                                                                                            color: FlutterAppTheme.of(context).secondaryText,
                                                                                          )),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    color: FlutterAppTheme.of(context).whiteColor,
                                                                                  ),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Expanded(
                                                                                              child: Row(
                                                                                            children: [
                                                                                              Card(
                                                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                                color: FlutterAppTheme.of(context).primaryColor,
                                                                                                shape: RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
                                                                                                  child: Container(
                                                                                                    width: 40,
                                                                                                    height: 40,
                                                                                                    clipBehavior: Clip.antiAlias,
                                                                                                    decoration: BoxDecoration(
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: Image.asset(
                                                                                                      "../../assets/images/user.png",
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                                child: Text(
                                                                                                  '${snapshot.data[index].adminName}',
                                                                                                  style: FlutterAppTheme.of(context).bodyText1,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          )),
                                                                                        ],
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                                                                                        child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(8),
                                                                                          child: Image.network(
                                                                                            '${snapshot.data[index].postPhoto}',
                                                                                            width: 350,
                                                                                            height: 300,
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 2, 5),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Expanded(
                                                                                                child: Row(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                                                                  child: Icon(
                                                                                                    Icons.favorite_border_outlined,
                                                                                                    color: FlutterAppTheme.of(context).secondaryText,
                                                                                                    size: 24,
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                                                                  child: Text(
                                                                                                    '2,493',
                                                                                                    style: FlutterAppTheme.of(context).bodyText2,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            )),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 2, 0),
                                                                                        child: Html(data: snapshot.data[index].postContenu),
                                                                                      ),
                                                                                    ],
                                                                                  ))),
                                                                        ],
                                                                      ),
                                                                    )));
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            'No shared posts with you',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterAppTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  color: FlutterAppTheme.of(
                                                                          context)
                                                                      .LightDarkTextColor,
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ));
                                                      }
                                                      return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0,
                                                                      280,
                                                                      0,
                                                                      0),
                                                          child:
                                                              const CircularProgressIndicatorWidget());
                                                    }))),
                                      ],
                                    ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
