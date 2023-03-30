import 'package:flutter/material.dart';

class errorAlertDialogWidget extends StatefulWidget {
  final String content;
  const errorAlertDialogWidget({this.content}) : super();

  @override
  _errorAlertDialogWidgetState createState() => _errorAlertDialogWidgetState();
}

class _errorAlertDialogWidgetState extends State<errorAlertDialogWidget> {
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text(widget.content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Ok'),
        ),
      ],
    );
  }
}
