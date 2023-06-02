import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeleton/themes/theme.dart';
import 'package:skeleton/user-profile/profile-controller.dart';
import '../index.dart';
import '../social-post/all-posts/all-posts-controller.dart';
import '../social-post/all-posts/all-posts-model.dart';
import '../social-post/all-saved-posts/all-saved-posts-controller.dart';

class PostsListingWidget extends StatefulWidget {
  PostsListingWidget({Key key,}) : super(key: key);
    
  @override
  _PostsListingWidgetWidgetState createState() => _PostsListingWidgetWidgetState();
 
}
  class _PostsListingWidgetWidgetState extends State<PostsListingWidget> {
  Future<List<Post>> futurePost;
  SavedPostMan savedPostsServices = SavedPostMan();
  Future<String> _currentUserIdFuture;
  String _currentUserId;
  ProfilingMan profilingUserServives = ProfilingMan();
  PostsUserMan postsServices = PostsUserMan();

  @override
  void initState() {
    super.initState();
    _currentUserIdFuture = _getCurrentUserId();
    _getFutureStringValue();
    futurePost = postsServices.getAllPostsForUsers();
  }

  Future<String> _getCurrentUserId() async {
    return profilingUserServives.GetIDCurrentUser();
  }

  void _getFutureStringValue() async {
    String value = await _currentUserIdFuture;
    setState(() {
      _currentUserId = value;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FutureBuilder<List< Post>>(
                  future: futurePost,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_,index) =>
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8,0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 2, 0, 15),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(9, 15, 10, 0),
                                    child: Html(data: snapshot.data[index].contenu, style: {
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
                                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
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
                                        width: 160,
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
                                                bool response = await savedPostsServices.SavePost(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].contenu, snapshot.data[index].date, snapshot.data[index].uname, snapshot.data[index].uphoto, _currentUserId);
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 170, 0, 0),
                      child: CircularProgressIndicatorWidget(),
                    );
                  }
                )
              ),
            ],
          ),
        ],
      )
    );
  }
}