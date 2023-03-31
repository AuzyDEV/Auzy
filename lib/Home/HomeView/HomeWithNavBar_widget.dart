import '../../CommonWidgets/LeftDrawer.dart';
import '../../themes/theme.dart';
import '../../DataBase/DataBaseView/doctorsListing_widget.dart';
import 'home_widget.dart';
import '../../index.dart';
import 'package:flutter/material.dart';

class HomeWithButtomNavBarWidget extends StatefulWidget {
  const HomeWithButtomNavBarWidget({Key key}) : super(key: key);

  @override
  _HomeWithButtomNavBarWidgetState createState() =>
      _HomeWithButtomNavBarWidgetState();
}

class _HomeWithButtomNavBarWidgetState
    extends State<HomeWithButtomNavBarWidget> {
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
    HomeWidget(),
    postsForUsersWidget(),
    listsdocWidget(),
    MyprofilWidget()
  ];
  final List<Widget> _pagesAdmin = [
    HomeWidget(),
    PostsManagementWidget(),
    listsdocWidget(),
    MyprofilWidget()
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _futureRoleValue == "admin"
          ? _pagesAdmin[_currentIndex]
          : _pagesUser[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: FlutterAppTheme.of(context).ButtonPrimaryColor,
        unselectedItemColor: FlutterAppTheme.of(context).Grey,
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
              icon: Icon(
                Icons.favorite_sharp,
              ),
              label: 'Posts'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_search,
              ),
              label: 'Doctors'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_sharp,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
