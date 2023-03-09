import 'package:flutter_svg/svg.dart';
import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/components/drawer.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/mailing/annoucement.dart';
import 'package:new_mee/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_mee/components/theme.dart';
import 'package:new_mee/components/util.dart';
import 'package:new_mee/components/widgets.dart';
import 'package:new_mee/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_chooser/emoji_chooser.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class welcomeWidget extends StatefulWidget {
  const welcomeWidget({Key key}) : super(key: key);

  @override
  _welcomeWidgetState createState() => _welcomeWidgetState();
}

class _welcomeWidgetState extends State<welcomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _futureRoleValue;
  Future<String> _getCurrentUserRole() async {
    return apiUser.GetCurrentUserRole();
  }

  void _getFutureRoleValue() async {
    String value = await _getCurrentUserRole();
    setState(() {
      _futureRoleValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFutureRoleValue();
  }

  final List<Widget> _pagesUser = [
    MenuWidget(),
    postsForUsersWidget(),
    MyprofilWidget(),
  ];
  final List<Widget> _pagesAdmin = [
    MenuWidget(),
    PostsManagementWidget(),
    MyprofilWidget(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _futureRoleValue == "admin"
          ? _pagesAdmin[_currentIndex]
          : _pagesUser[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color(0xff132137),
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_sharp,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_sharp), label: 'Posts'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
