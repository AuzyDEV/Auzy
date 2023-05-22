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
                              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Welcome',
                                        style: FlutterAppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                                        child: Text('${snapshot.data.displayName}',
                                          style: FlutterAppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: FlutterAppTheme.of(context).whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            "../assets/images/user.png",
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
                            Divider(
                              height: 12,
                              indent: 50,
                              endIndent: 50,
                              color: FlutterAppTheme.of(context).lightGrey,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                                  Row(
                                    children: [
                                      Text( "Discover our guidance",
                                        style: FlutterAppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                                                          padding: EdgeInsetsDirectional.fromSTEB(0,8,0,0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: FlutterAppTheme.of(context).secondaryText,
                                                                width: 0.5,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8.0),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsetsDirectional.fromSTEB(16,8,16, 8),
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
                                                                                    child: Image.asset(
                                                                                      "../../assets/images/user.png",
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                child: Text('${snapshot.data[index].uname}',
                                                                                  style: FlutterAppTheme.of(context).bodyText1,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ),
                                                                        snapshot.data[index].existsInCollection2 == "false" 
                                                                          ? Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                            child: FlutterFlowIconButton(
                                                                              borderColor: Colors.transparent,
                                                                              borderRadius: 30,
                                                                              buttonSize: 46,
                                                                              icon: Icon(
                                                                                Icons.bookmark_outline_outlined,
                                                                                color: Colors.grey,
                                                                                size: 23,
                                                                              ),
                                                                              onPressed: () async {
                                                                                bool response = await savedPostsServices.SavePost(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].contenu, snapshot.data[index].date, snapshot.data[index].uname, snapshot.data[index].uphoto, _CurrentUserId);
                                                                                await Navigator.push( context,
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
                                                                  ClipRRect(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    child: Image.network(
                                                                      '${snapshot.data[index].downloadURL}',
                                                                      width: 350,
                                                                      height: 300,
                                                                      fit: BoxFit.cover,
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
                                                                                  color: Colors.grey,
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
                                                                          )
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                                          child: InkWell(
                                                                            onTap: () async {
                                                                              await Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) => UsersListForPostsWidget(postId: snapshot.data[index].id, Postcontenu: snapshot.data[index].contenu, postImage: snapshot.data[index].downloadURL, CurrentuserId: _CurrentUserId, adminName: snapshot.data[index].uname, adminPhoto: snapshot.data[index].uphoto)),
                                                                              );
                                                                            },
                                                                            child: Icon(
                                                                              Icons.ios_share_sharp,
                                                                              color: Colors.grey,
                                                                              size: 23,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 2, 0),
                                                                    child: Html(
                                                                          data: "${snapshot.data[index].contenu}", 
                                                                          style: {
                                                                          '#': Style(
                                                                            maxLines: 2,
                                                                            textOverflow: TextOverflow.ellipsis,
                                                                          ),
                                                                          }
                                                                        ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start, 
                                                                    children: [
                                                                      GestureDetector(
                                                                        child: Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 2, 0), 
                                                                          child:Text(
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
                                                                    ]
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 2, 12),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text('${snapshot.data[index].date}',
                                                                            textAlign: TextAlign.right,
                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          )
                                                        ),
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
