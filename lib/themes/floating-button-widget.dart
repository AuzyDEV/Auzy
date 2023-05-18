import 'package:flutter/material.dart';
import 'theme.dart';

class floatingActionButtonWidget extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const floatingActionButtonWidget({this.icon, this.onPressed}) : super();

  @override
  _floatingActionButtonWidgetState createState() =>  _floatingActionButtonWidgetState();
}

class _floatingActionButtonWidgetState extends State<floatingActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      backgroundColor: FlutterAppTheme.of(context).ButtonPrimaryColor,
      elevation: 2,
      child: Icon(widget.icon),
    );
  }
}
