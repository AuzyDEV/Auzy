import 'dart:convert';
import 'package:new_mee/social-post/single-post/single-post-view.dart';
import 'package:new_mee/user-profile/profile-controller.dart';

import '../../../themes/app-bar-widget.dart';
import '../../../themes/left-drawer.dart';
import '../../../themes/loading-spinner.dart';
import '../../../themes/snack-bar-widget.dart';
import '../../../themes/theme.dart';

import '../../admin-functions/user-management/profil-user/profil-user-view.dart';
import '../../themes/icon-button-widget.dart';
import 'all-posts-controller.dart';
import '../all-saved-posts/all-saved-posts-controller.dart';
import '../share-post/share-post-controller.dart';

import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'all-posts-model.dart';
import '../all-saved-posts/all-saved-posts-model.dart';
import '../share-post/share-post-model.dart';
import '../all-saved-posts/all-saved-posts-view.dart';
import 'package:flutter_html/flutter_html.dart';
import '../share-post/users-list-for-share-post-widget.dart';

class postsForUsersWidget extends StatefulWidget {
  const postsForUsersWidget({Key key}) : super(key: key);

  @override
  _postsForUsersWidgetState createState() => _postsForUsersWidgetState();
}

class _postsForUsersWidgetState extends State<postsForUsersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Post>> futurePost;
  PostsUserMan apiPost = PostsUserMan();
  SavedPostMan apisavedpost = SavedPostMan();
  ProfilingMan apiUser = ProfilingMan();
  String _CurrentUserId;
  bool _iconToggled = false;
  Future<List<savedPost>> futureSavedPost;
  SavedPostMan apiSavedPost = SavedPostMan();
  sharedPostMan sharedpostapi = sharedPostMan();
  String htmlText =
      "<h2><span style=\"background-color: rgb(255, 255, 255);\"><font color=\"#e91e63\" style=\"\" size=\"3\">Summer</font></span><span style=\"color: rgb(77, 81, 86); font-size: 14px; background-color: rgb(255, 255, 255);\"> is the <u>hottest</u> of the </span><span style=\"font-size: 14px; background-color: rgb(255, 255, 255);\"><font color=\"#fe1616\">four</font></span><span style=\"color: rgb(77, 81, 86); font-size: 14px; background-color: rgb(255, 255, 255);\"> temperate seasons, occurring after spring and before autumn. At or </span><span style=\"color: rgb(77, 81, 86); font-size: 14px; background-color: rgb(255, 235, 59);\">centred</span><span style=\"color: rgb(77, 81, 86); font-size: 14px; background-color: rgb(255, 255, 255);\"> on the summer solstice, daylight hours are longest and darkness hours are shortest, with day length decreasing as the season progresses after the solstice.</span></h2>";
  int number;
  Future<String> _getCurrentUserId() async {
    return apiUser.GetIDCurrentUser();
  }

  // Function to get the value of Future<String>
  void _getFutureStringValue() async {
    String value = await _getCurrentUserId();
    setState(() {
      _CurrentUserId = value;
    });
  }

  Future<int> _getCountSavedPosts(String id) async {
    number = await apisavedpost.countSavedPosts(id);
    return number;
  }

  Text getTextSpanFromRichTextJson(String jsonString) {
    final parsedJson = json.decode(jsonString);
    final List<dynamic> textObjects = parsedJson as List<dynamic>;
    final List<TextSpan> textSpans = [];

    for (final textObject in textObjects) {
      final String text = textObject['insert'];
      final Map<String, dynamic> attributes = textObject['attributes'] ?? {};

      // Determine which styles should be applied based on the attributes
      final bool isBold = attributes['bold'] ?? false;
      final bool isItalic = attributes['italic'] ?? false;
      final bool isUnderline = attributes['underline'] ?? false;
      final bool isStrikethrough = attributes['strike'] ?? false;
      final int headerLevel = attributes['header'] ?? 0;
      final String fontColor = attributes['color'] ?? '';
      final double fontSize = attributes['size'] ?? 14.0;

      // Create a TextStyle with the appropriate styles
      final TextStyle textStyle = TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        decoration: isUnderline
            ? TextDecoration.underline
            : isStrikethrough
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontSize: headerLevel == 1 ? 28.0 : fontSize,
        color: fontColor.isNotEmpty
            ? Color(
                int.parse(fontColor.substring(1, 7), radix: 16) + 0xFF000000)
            : null,
      );

      // Create a TextSpan for the current object
      final TextSpan textSpan = TextSpan(text: text, style: textStyle);

      // If this object represents a header, wrap the TextSpan in a header widget
      if (headerLevel > 0) {
        textSpans.add(
          TextSpan(
            text: text,
            style: textStyle.copyWith(
              fontSize: headerLevel == 1 ? 28 : 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        textSpans.add(textSpan);
      }
    }

    return Text.rich(TextSpan(children: textSpans),
        maxLines: 3, overflow: TextOverflow.ellipsis);
  }

  @override
  void initState() {
    super.initState();
    _getFutureStringValue();
    _getCountSavedPosts(_CurrentUserId);

    futurePost = apiPost.getAllPostsForUsers();
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
                        unselectedLabelColor: FlutterAppTheme.of(context).Grey,
                        labelStyle: GoogleFonts.getFont(
                          'Roboto',
                        ),
                        indicatorColor:
                            FlutterAppTheme.of(context).primaryColor,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(
                            text: 'Posts',
                          ),
                          Tab(
                            text: 'Saved',
                          ),
                          Tab(
                            text: "Shared",
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
                                                                                          child: Image.network(
                                                                                            '${snapshot.data[index].uphoto}',
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
                                                                                          borderColor: FlutterAppTheme.of(context).TransparentColor,
                                                                                          borderRadius: 30,
                                                                                          buttonSize: 46,
                                                                                          icon: Icon(
                                                                                            Icons.bookmark_outline_outlined,
                                                                                            color: FlutterAppTheme.of(context).Grey,
                                                                                            size: 23,
                                                                                          ),
                                                                                          onPressed: () async {
                                                                                            bool response = await apisavedpost.SavePost(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].contenu, snapshot.data[index].date, snapshot.data[index].uname, snapshot.data[index].uphoto, _CurrentUserId);
                                                                                            print(response);
                                                                                            await Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) => savedPostsForUsersWidget(),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      )
                                                                                    : Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                        child: FlutterFlowIconButton(
                                                                                          borderColor: FlutterAppTheme.of(context).TransparentColor,
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
                                                                                        color: FlutterAppTheme.of(context).Grey,
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
                                                                                      color: FlutterAppTheme.of(context).Grey,
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
                                                                                //getTextSpanFromRichTextJson(snapshot.data[index].contenu),
                                                                                Html(data: snapshot.data[index].contenu),
                                                                            // Html(data: HtmlUnescape().convert(snapshot.data[index].contenu)),
                                                                          ),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                GestureDetector(
                                                                                  child: Text(
                                                                                    "See all",
                                                                                    style: TextStyle(
                                                                                      color: FlutterAppTheme.of(context).tertiaryColor,
                                                                                      decoration: TextDecoration.underline,
                                                                                    ),
                                                                                  ),
                                                                                  onTap: () {
                                                                                    print(htmlText);
                                                                                    print(snapshot.data[index].contenu);
                                                                                    /*Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(builder: (context) => postDetailsWidget(id: snapshot.data[index].id)),
                                                                                    );*/
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
                                                                '${snapshot.error}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterAppTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Roboto',
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ));
                                                          }
                                                          return Center(
                                                            child:
                                                                const CircularProgressIndicatorWidget(),
                                                          );
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
                                                      future: apiSavedPost
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
                                                                        // Generated code for this userInfo Widget...
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
                                                                                    child: Image.network(
                                                                                      '${snapshot.data[index].uphoto}',
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
                                                                                      borderColor: FlutterAppTheme.of(context).TransparentColor,
                                                                                      borderRadius: 30,
                                                                                      buttonSize: 46,
                                                                                      icon: Icon(
                                                                                        Icons.bookmark,
                                                                                        color: Colors.amber,
                                                                                        size: 23,
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        print(snapshot.data[index].id);
                                                                                        bool response = await apisavedpost.DeleteSavedPost(snapshot.data[index].id);
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
                                                                                            'Successfully save deleted!',
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
                                                                          child: getTextSpanFromRichTextJson(snapshot
                                                                              .data[index]
                                                                              .postContenu),
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              GestureDetector(
                                                                                child: Text(
                                                                                  "See all",
                                                                                  style: TextStyle(
                                                                                    color: FlutterAppTheme.of(context).tertiaryColor,
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
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ));
                                                        }
                                                        return Center(
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
                                                    future: sharedpostapi
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
                                                                                            color: FlutterAppTheme.of(context).Grey,
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
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                                        child: Row(
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
                                                                                                      child: Image.network(
                                                                                                        '${snapshot.data[index].adminPhoto}',
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
                                                                                                    color: FlutterAppTheme.of(context).Grey,
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
                                                                                        child: getTextSpanFromRichTextJson(snapshot.data[index].postContenu),
                                                                                      ),
                                                                                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                        GestureDetector(
                                                                                          child: Text(
                                                                                            "See all",
                                                                                            style: TextStyle(
                                                                                              color: FlutterAppTheme.of(context).tertiaryColor,
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
                                                                                  ))),
                                                                          Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 2, 0),
                                                                              child: Divider(
                                                                                color: FlutterAppTheme.of(context).Grey,
                                                                                thickness: 1,
                                                                                endIndent: 50,
                                                                                indent: 50,
                                                                              )),
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
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ));
                                                      }
                                                      return Center(
                                                        child:
                                                            const CircularProgressIndicatorWidget(),
                                                      );
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
