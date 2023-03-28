import 'package:new_mee/common_widgets/widgets.dart';
import 'package:new_mee/themes/theme.dart';
import 'package:flutter/material.dart';

class floatingActionButtonWidget extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const floatingActionButtonWidget({this.icon, this.onPressed}) : super();

  @override
  _floatingActionButtonWidgetState createState() =>
      _floatingActionButtonWidgetState();
}

class _floatingActionButtonWidgetState
    extends State<floatingActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      backgroundColor: Color(0xFF101213),
      elevation: 2,
      child: Icon(widget.icon),
    );
  }
}
