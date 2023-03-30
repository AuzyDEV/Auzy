import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

import '../../services/postMan.dart';
import '../../common_widgets/Button_widget.dart';
import '../../common_widgets/app_bar.dart';
import '../../common_widgets/drawer.dart';
import '../../models/Post.dart';
import '../../common_widgets/icon_button.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'updateImagePost_widget.dart';

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
  PostMan apiPost = PostMan();
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

  Future<String> _getCurrentUserRole() async {
    return apiUser.GetCurrentUserRole();
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
    _futurePost = apiPost.getPostDetails(widget.id);
    print(widget.id);
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 16, 16, 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                color:
                                                    FlutterAppTheme.of(context)
                                                        .TransparentColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: FlutterFlowIconButton(
                                                  borderColor:
                                                      FlutterAppTheme.of(
                                                              context)
                                                          .TransparentColor,
                                                  borderRadius: 30,
                                                  buttonSize: 46,
                                                  icon: Icon(
                                                    Icons.arrow_back_rounded,
                                                    color: FlutterAppTheme.of(
                                                            context)
                                                        .whiteColor,
                                                    size: 24,
                                                  ),
                                                  onPressed: () {
                                                    print(
                                                        'IconButton pressed ...');
                                                  },
                                                ),
                                              ),
                                              Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                color:
                                                    FlutterAppTheme.of(context)
                                                        .TransparentColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: FlutterFlowIconButton(
                                                  borderColor:
                                                      FlutterAppTheme.of(
                                                              context)
                                                          .TransparentColor,
                                                  borderRadius: 30,
                                                  buttonSize: 46,
                                                  icon: Icon(
                                                    Icons.favorite_border,
                                                    color: FlutterAppTheme.of(
                                                            context)
                                                        .whiteColor,
                                                    size: 24,
                                                  ),
                                                  onPressed: () {
                                                    print(
                                                        'IconButton pressed ...');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
                                  child: buttonWidget(
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

                  // By default, show a loading spinner.
                  return Center(child: const CircularProgressIndicator());
                })));
  }
}
