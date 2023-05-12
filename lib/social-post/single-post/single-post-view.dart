import 'package:flutter_html/flutter_html.dart';
import '../../index.dart';
import '../../user-profile/profile-controller.dart';
import '../all-posts/all-posts-model.dart';
import 'single-post-controller.dart';
import '../../../../themes/theme.dart';
import 'package:flutter/material.dart';

class postDetailsWidget extends StatefulWidget {
  final String id;
  const postDetailsWidget({Key key, this.id}) : super(key: key);

  @override
  _postDetailsWidgetState createState() => _postDetailsWidgetState();
}

class _postDetailsWidgetState extends State<postDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<Post> _futurePost;
  String _futureStringValue;
  SinglePostMan singlePostServices = SinglePostMan();
  ProfilingMan profilingUserServices = ProfilingMan();

  Future<String> _getCurrentUserRole() async {
    return profilingUserServices.GetCurrentUserRole();
  }

  void _getFutureStringValue() async {
    String value = await _getCurrentUserRole();
    setState(() {
      _futureStringValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFutureStringValue();
    _futurePost = singlePostServices.getPostDetails(widget.id);
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
          child: appbar(text: 'Post details'),
        ),
        drawer: Drawerr(),
        body: SingleChildScrollView(
            child: FutureBuilder<Post>(
                future: _futurePost,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 320,
                                decoration: BoxDecoration(
                                  color: FlutterAppTheme.of(context).whiteColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          '${snapshot.data.files[0].downloadURL}',
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '${snapshot.data.title}',
                                style: FlutterAppTheme.of(context).title1,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Html(data: snapshot.data.contenu),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${snapshot.data.date}',
                                  textAlign: TextAlign.right,
                                  style: FlutterAppTheme.of(context).bodyText1,
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
                              if (_futureStringValue == "admin")
                                Expanded(
                                  child: CustomButton(
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              updateImagePostWidget(
                                                  id: widget.id.toString(),
                                                  downloadURL: snapshot.data
                                                      .files[0].downloadURL),
                                        ),
                                      );
                                    },
                                    text: 'update post\'s photo',
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

                   return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 300, 0, 0),
                    child: const CircularProgressIndicatorWidget());
                })));
  }
}
