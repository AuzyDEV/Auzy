import 'package:new_mee/common_widgets/FFButtonWidget.dart';
import 'package:new_mee/themes/theme.dart';
import 'package:flutter/material.dart';

class alertDialogWidget extends StatefulWidget {
  final String title;
  final String content;
  final List<Widget> actions;
  const alertDialogWidget({this.title, this.content, this.actions}) : super();

  @override
  _alertDialogWidgetState createState() => _alertDialogWidgetState();
}

class _alertDialogWidgetState extends State<alertDialogWidget> {
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: widget.actions ??
          <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
    );
  }
}
