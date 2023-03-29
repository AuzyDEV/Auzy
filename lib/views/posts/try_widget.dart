import 'dart:convert';

import 'package:flutter/material.dart';

class tryingWidget extends StatefulWidget {
  const tryingWidget({Key key}) : super(key: key);

  @override
  _tryingWidgetState createState() => _tryingWidgetState();
}

class _tryingWidgetState extends State<tryingWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String json =
        '[{"insert": "haifa"}, {"insert": "tanazefti", "attributes": {"bold": true}}, {"insert": "1997", "attributes": {"bold": true, "italic": true}}, {"insert": "tunis", "attributes": {"bold": true, "italic": true, "underline": true}}, {"insert": ""}]';
    List<dynamic> data = jsonDecode(json);
    // Create list of TextSpan
    List<TextSpan> textSpans = [];
    for (Map<String, dynamic> segment in data) {
      // Check for attributes
      bool bold = segment['attributes'] != null &&
          segment['attributes']['bold'] == true;
      bool italic = segment['attributes'] != null &&
          segment['attributes']['italic'] == true;
      bool underline = segment['attributes'] != null &&
          segment['attributes']['underline'] == true;

      // Create TextSpan
      TextSpan textSpan = TextSpan(
        text: segment['insert'],
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none,
        ),
      );

      // Add to list
      textSpans.add(textSpan);
    }

    return Text.rich(
      TextSpan(children: textSpans),
    );
  }
}
