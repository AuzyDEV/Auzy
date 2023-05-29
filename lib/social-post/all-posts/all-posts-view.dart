import 'package:html_unescape/html_unescape.dart';

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
  int itemCount = 2;
  ScrollController _scrollController = ScrollController();

  Future<String> _getCurrentUserId() async {
    return profilingUserServices.GetIDCurrentUser();
  }

  void _getFutureStringValue() async {
    String value = await _getCurrentUserId();
    setState(() {
      _CurrentUserId = value;
    });
  }
  String extractPlainTextFromHTML(String htmlString) {
  final unescape = HtmlUnescape();
  
  // Remove HTML tags using regular expressions
  final noTags = htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  
  // Decode HTML entities using the html_unescape package
  final plainText = unescape.convert(noTags);
  
  return plainText;
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
                        unselectedLabelColor: FlutterAppTheme.of(context).tabBarText,
                        labelStyle: GoogleFonts.getFont('Roboto',),
                        indicatorColor: FlutterAppTheme.of(context).primaryColor,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(text: 'All Posts',),
                          Tab(text: 'Saved Posts',)
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                            child: FutureBuilder<List<Post>>(
                                              future: futurePost,
                                              builder: (context,snapshot) {
                                                if (snapshot.hasData) {
                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    controller: _scrollController,
                                                    itemCount: snapshot.data.length,
                                                    itemBuilder: (_,index) =>
                                                     Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(8,12,8,0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: FlutterAppTheme.of(context).secondaryText,
                                                            width: 0.5,
                                                          ),
                                                          borderRadius: BorderRadius.circular(8.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 2),
                                                                            child: Text(
                                                                              '${snapshot.data[index].title}',
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 20
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(8, 2, 0, 15),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        '${snapshot.data[index].date}',
                                                                        textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Colors.grey
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ),
                                                              ClipRRect(
                                                                child: Image.network(
                                                                  '${snapshot.data[index].downloadURL}',
                                                                  height: 300,
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(0,2,0, 0),
                                                                child:
                                                                  Html(data: snapshot.data[index].contenu, style: {
                                                                  '#': Style(
                                                                    maxLines: 3,
                                                                    textOverflow: TextOverflow.ellipsis,
                                                                    ),
                                                                  }
                                                                ),
                                                              ),
                                                              //Text(extractPlainTextFromHTML(snapshot.data[index].contenu)),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                    child: Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                      child: Text(
                                                                        "Read more",
                                                                        style: TextStyle(
                                                                          color: Colors.blue,
                                                                          decoration: TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator.push(context,
                                                                        MaterialPageRoute(builder: (context) => postDetailsWidget(id: snapshot.data[index].id)),
                                                                      );
                                                                    },
                                                                  ),
                                                                  Container(
                                                                    width: 175,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                    child: InkWell(
                                                                      onTap: () async {
                                                                        await Navigator.push(context,
                                                                          MaterialPageRoute(builder: (context) => UsersListForPostsWidget(postId: snapshot.data[index].id, Postcontenu: snapshot.data[index].contenu, postImage: snapshot.data[index].downloadURL, CurrentuserId: _CurrentUserId, adminName: snapshot.data[index].uname, adminPhoto: snapshot.data[index].uphoto)),
                                                                        );
                                                                      },
                                                                      child: Icon(
                                                                        Icons.logout_outlined,
                                                                        color: FlutterAppTheme.of(context).secondaryText,
                                                                        size: 20,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  snapshot.data[index].existsInCollection2 == "false" ? 
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                        child: FlutterFlowIconButton(
                                                                          borderColor: Colors.transparent,
                                                                          icon: Icon(
                                                                            Icons.bookmark_outline_outlined,
                                                                            color: FlutterAppTheme.of(context).secondaryText,
                                                                            size: 20,
                                                                          ),
                                                                          onPressed: () async {
                                                                            bool response = await savedPostsServices.SavePost(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].contenu, snapshot.data[index].date, snapshot.data[index].uname, snapshot.data[index].uphoto, _CurrentUserId);
                                                                            await Navigator.push(context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => postsForUsersWidget(),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                                    : Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                        child: FlutterFlowIconButton(
                                                                          borderColor: Colors.transparent,
                                                                          icon: Icon(
                                                                            Icons.bookmark_outlined,
                                                                            color: Colors.amber,
                                                                            size: 20,
                                                                          ),
                                                                          onPressed: () async {},
                                                                        ),
                                                                      )
                                                                  
                                                                ]
                                                              ),
                                                            ],
                                                          )
                                                        ),
                                                      ),
                                                    )
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Text('There is no posts',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterAppTheme.of(context).bodyText2.override(
                                                      color: FlutterAppTheme.of( context).LightDarkTextColor,
                                                      fontFamily:'Roboto',
                                                      fontSize: 17,
                                                      fontWeight:FontWeight.bold,
                                                    )
                                                  );
                                                }
                                                return Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB( 0, 280,0, 0),
                                                  child: const CircularProgressIndicatorWidget()
                                                );
                                              }
                                            )
                                          )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                            child: FutureBuilder<List<savedPost>>(
                                              future: savedPostsServices.getAllSavedPostsForUsers(_CurrentUserId),
                                              builder:(context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    controller: _scrollController,
                                                    itemCount: snapshot.data.length,
                                                    itemBuilder: (_,index) =>
                                                      Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(8,12,8,0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: FlutterAppTheme.of(context).secondaryText,
                                                            width: 0.5,
                                                          ),
                                                          borderRadius: BorderRadius.circular(8.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(8,8,8, 8),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 2),
                                                                            child: Text(
                                                                              '${snapshot.data[index].postTitle}',
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 20
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(8, 2, 0, 15),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        '${snapshot.data[index].date}',
                                                                        textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Colors.grey
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ),
                                                              ClipRRect(
                                                                child: Image.network(
                                                                  '${snapshot.data[index].files[0].downloadURL}',
                                                                  height: 300,
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(0,2, 0,0),
                                                                child: Html(data: snapshot.data[index].postContenu),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                    child: Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                      child: Text(
                                                                        "Read more",
                                                                        style: TextStyle(
                                                                          color: Colors.blue,
                                                                          decoration: TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator.push(context,
                                                                        MaterialPageRoute(builder: (context) => postDetailsWidget(id: snapshot.data[index].id)),
                                                                      );
                                                                    },
                                                                  ),
                                                                  Container(
                                                                    width: 180,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                    child: FlutterFlowIconButton(
                                                                      borderColor: Colors.transparent,
                                                                      icon: Icon(
                                                                        Icons.bookmark_outlined,
                                                                        color: Colors.amber,
                                                                        size: 20,
                                                                        ),
                                                                        onPressed: () async {
                                                                          bool response = await savedPostsServices.DeleteSavedPost(snapshot.data[index].id);
                                                                          if (response == true)
                                                                            Navigator.push(context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => postsForUsersWidget(),
                                                                              ),
                                                                            );
                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                            SnackbarWidget(
                                                                              content: Text('Successfully saved post deleted!',
                                                                              )
                                                                            ),
                                                                          );
                                                                        },
                                                                    ),
                                                                  )
                                                                ]
                                                              ),
                                                            ],
                                                          )
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                    'There is no saved posts',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterAppTheme.of(context).bodyText2.override(
                                                      color: FlutterAppTheme.of(context).LightDarkTextColor,
                                                      fontFamily:'Roboto',
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.bold,
                                                    )
                                                  );
                                                }
                                                return Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 280, 0, 0),
                                                  child:const CircularProgressIndicatorWidget()
                                                );
                                              }
                                            )
                                          )
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
