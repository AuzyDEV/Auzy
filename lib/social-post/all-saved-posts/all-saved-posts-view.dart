import 'dart:convert';
import 'package:new_mee/social-post/all-posts/all-posts-view.dart';
import 'package:new_mee/user-profile/profile-controller.dart';
import '../../themes/icon-button-widget.dart';
import 'all-saved-posts-controller.dart';
import '../../../themes/alert-popup.dart';
import '../../../themes/app-bar-widget.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/floating-button-widget.dart';
import '../../../themes/left-drawer.dart';
import '../../../themes/loading-spinner.dart';
import '../../../themes/snack-bar-widget.dart';
import '../../../themes/theme.dart';
import '../../index.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'all-saved-posts-model.dart';

class savedPostsForUsersWidget extends StatefulWidget {
  const savedPostsForUsersWidget({Key key}) : super(key: key);

  @override
  _savedPostsForUsersWidgetState createState() =>
      _savedPostsForUsersWidgetState();
}

class _savedPostsForUsersWidgetState extends State<savedPostsForUsersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<savedPost>> futurePost;
  SavedPostMan apiSavedPost = SavedPostMan();
  ProfilingMan apiUser = ProfilingMan();
  String _CurrentUserId;
  int n;
  SavedPostMan apisavedpost = SavedPostMan();

  Future<String> _getCurrentUserId() async {
    return apiUser.GetIDCurrentUser();
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
        fontSize: fontSize,
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
            TextSpan(text: '\n', style: TextStyle(height: 0.0, fontSize: 1.0)));
        textSpans.add(
          TextSpan(
            text: text,
            style: textStyle.copyWith(
              fontSize: headerLevel == 1 ? 24.0 : 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        textSpans.add(
            TextSpan(text: '\n', style: TextStyle(height: 0.0, fontSize: 1.0)));
      } else {
        textSpans.add(textSpan);
      }
    }

    return Text.rich(
      TextSpan(children: textSpans),
    );
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
    print(_CurrentUserId);

    //futurePost = apiSavedPost.getAllSavedPostsForUsers(_CurrentUserId);

    //print(futurePost);
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
                child: FutureBuilder<List<savedPost>>(
                    future:
                        apiSavedPost.getAllSavedPostsForUsers(_CurrentUserId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) => Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              child: Column(
                                children: [
                                  // Generated code for this userInfo Widget...
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 2, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Card(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          color: FlutterAppTheme.of(context)
                                              .primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    1, 1, 1, 1),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 0, 0, 0),
                                                child: Text(
                                                  '${snapshot.data[index].uname}',
                                                  style: FlutterAppTheme.of(
                                                          context)
                                                      .bodyText1,
                                                ),
                                              ),
                                              FlutterFlowIconButton(
                                                borderColor:
                                                    FlutterAppTheme.of(context)
                                                        .TransparentColor,
                                                borderRadius: 30,
                                                buttonSize: 46,
                                                icon: Icon(
                                                  Icons.bookmark,
                                                  color: Colors.amber,
                                                  size: 20,
                                                ),
                                                onPressed: () async {
                                                  print(
                                                      snapshot.data[index].id);
                                                  bool response =
                                                      await apisavedpost
                                                          .DeleteSavedPost(
                                                              snapshot
                                                                  .data[index]
                                                                  .id);
                                                  if (response == true)
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            postsForUsersWidget(),
                                                      ),
                                                    );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          SnackbarWidget(
                                                    content: Text(
                                                      'Successfully save deleted!',
                                                    ),
                                                  ));
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
                                        0, 4, 0, 4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        '${snapshot.data[index].files[0].downloadURL}',
                                        width: 350,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 2, 0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 0, 0, 0),
                                          child: Text(
                                            '2,493',
                                            style: FlutterAppTheme.of(context)
                                                .bodyText2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 2, 0),
                                    child: getTextSpanFromRichTextJson(
                                        snapshot.data[index].postContenu),
                                  ),
                                ],
                              )),
                        );
                      } else if (snapshot.hasError) {
                        return Text('There is no saved posts',
                            textAlign: TextAlign.center,
                            style:
                                FlutterAppTheme.of(context).bodyText2.override(
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ));
                      }
                      return const CircularProgressIndicatorWidget();
                    }))
          ],
        ),
      ),
    );
  }
}
