
import '../themes/theme.dart';
import 'package:flutter/material.dart';

class appbar extends StatefulWidget {
  final String text;
  const appbar({this.text}) : super();

  @override
  _appbarState createState() => _appbarState();
}

class _appbarState extends State<appbar> {
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: FlutterAppTheme.of(context).AppBarPrimaryColor,
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(
          Icons.sort_outlined,
          size: 30,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(
        widget.text,
        style: FlutterAppTheme.of(context).bodyText2.override(
              fontFamily: 'Roboto',
              color: FlutterAppTheme.of(context).whiteColor,
              fontSize: 18,
            ),
      ),
      actions: [],
      centerTitle: true,
      elevation: 2,
    );
  }
}
