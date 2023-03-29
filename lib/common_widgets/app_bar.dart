import 'package:new_mee/themes/theme.dart';
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
      backgroundColor: Color(0xff132137),
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
        style: FlutterAppTheme.of(context).bodyText1.override(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 18,
            ),
      ),
      actions: [
        /*  Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
          child: Badge(
            badgeContent: Text(
              '1',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
            ),
            showBadge: true,
            shape: BadgeShape.circle,
            badgeColor: Color(0xFFFF0000),
            elevation: 4,
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            position: BadgePosition.topEnd(),
            animationType: BadgeAnimationType.scale,
            toAnimate: true,
            child: FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
    */
      ],
      centerTitle: true,
      elevation: 4,
    );
  }
}
