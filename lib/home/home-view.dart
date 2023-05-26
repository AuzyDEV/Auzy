import 'package:flutter_html/flutter_html.dart';
import '../../../themes/theme.dart';
import 'package:skeleton/user-profile/profile-controller.dart';
import 'package:skeleton/user-profile/profile-model.dart';
import 'package:flutter/material.dart';
import '../index.dart';
import '../social-post/all-posts/all-posts-controller.dart';
import '../social-post/all-posts/all-posts-model.dart';
import '../social-post/all-saved-posts/all-saved-posts-controller.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String stringValue;
  int numberUsers;
  Future<List<Post>> futurePost;
  PostsUserMan postsServices = PostsUserMan();
  SavedPostMan savedPostsServices = SavedPostMan();
  ProfilingMan profilingUserServices = ProfilingMan();
  String _CurrentUserId;
  final TextEditingController _controller = TextEditingController();
  Future<User> _futureUser;
  ProfilingMan profilingUserServives = ProfilingMan();

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
    futurePost = postsServices.getAllPostsForUsers();
    _futureUser = profilingUserServives.GetCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Home'),
      ),
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: FutureBuilder<User>(
                    future: _futureUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    children: [
                                      Text("Find a doctor",
                                        style: FlutterAppTheme.of(context).bodyText1.override(
                                          fontFamily:'Roboto',
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          height: 140,
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllListingsWidget(
                                                        speciality:
                                                            "Neurologist",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                        child: InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          child: Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFFF1F4F8),
                                                              boxShadow: [
                                                                BoxShadow( blurRadius: 0, color: Color(0x340F1113),
                                                                )
                                                              ],
                                                              shape: BoxShape.circle,
                                                            ),
                                                            alignment: AlignmentDirectional(0, 0),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                              child: Image.asset(
                                                                'assets/images/image_(1).png',
                                                                width: 35,
                                                                height: 35,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:  MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Expanded(
                                                            child: Text('Neurologist',
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => AllListingsWidget( speciality:"Ophtalmologist",),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                        child:InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          child: Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFFF1F4F8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 0,
                                                                  color: Color(0x340F1113),
                                                                )
                                                              ],
                                                              shape: BoxShape.circle,
                                                            ),
                                                            alignment: AlignmentDirectional(0, 0),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                              child: Image.asset(
                                                                'assets/images/image_(8).png',
                                                                width: 35,
                                                                height: 35,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:  MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Expanded(
                                                            child: Text('Ophtalmologist',
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context) => AllListingsWidget( speciality: "Psychiatrist",),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:  MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                        child: InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          child: Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFFF1F4F8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 0,
                                                                  color: Color(0x340F1113),
                                                                )
                                                              ],
                                                              shape: BoxShape.circle,
                                                            ),
                                                            alignment: AlignmentDirectional(0, 0),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                              child: Image.asset(
                                                                'assets/images/image_(4).png',
                                                                width: 35,
                                                                height: 35,
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Expanded(
                                                            child: Text('Psychiatrist',
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context) => AllListingsWidget(speciality: "Orthopdist",),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  decoration:
                                                    BoxDecoration(
                                                      color: Colors.transparent,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:  MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                        child: InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          child: Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFFF1F4F8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 0,
                                                                  color: Color(0x340F1113),
                                                                )
                                                              ],
                                                              shape: BoxShape.circle,
                                                            ),
                                                            alignment: AlignmentDirectional(0, 0),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                              child: Image.asset(
                                                                'assets/images/image_(9)(1).png',
                                                                width: 35,
                                                                height: 35,
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:  MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                              child: Text('Orthopdist',
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context) => SpecialitiesWidget(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  decoration:
                                                    BoxDecoration(
                                                      color: Colors.transparent,
                                                    ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                        child: InkWell(
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          child: Container(
                                                            width: 60,
                                                            height: 60,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xFFF1F4F8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius: 0,
                                                                  color: Color(0x340F1113),
                                                                )
                                                              ],
                                                              shape: BoxShape.circle,
                                                            ),
                                                            alignment: AlignmentDirectional(0, 0),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                              child: Icon(
                                                                Icons.keyboard_control,
                                                                color: Colors.black,
                                                                size: 24,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                              child: Text('See all',
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        )
                                      )
                                    ]
                                  ),
                                  Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                                  child: Row(
                                    children: [
                                      Text( "Discover our guidance",
                                        style: FlutterAppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                child: FutureBuilder<List< Post>>(
                                                  future: futurePost,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: snapshot.data.length,
                                                        itemBuilder: (_, index) =>
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0,12,0,0),
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
                                                      return Text('${snapshot.error}',
                                                        textAlign: TextAlign.center,
                                                        style: FlutterAppTheme.of(context).bodyText2.override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold,
                                                        )
                                                      );
                                                    }
                                                    return Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
                                                      child: CircularProgressIndicatorWidget(),
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
                                ]
                              )
                            ),
                          ]
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                          child: const CircularProgressIndicatorWidget(
                            color: Colors.transparent)
                      );
                    }
                  ),
                )
              ],
            ),
          )
        )
      )
    );
  }
}
