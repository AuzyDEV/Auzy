import 'package:new_mee/components/drawer.dart';
import 'package:new_mee/doctors/doctorsListing_widget.dart';
import 'package:new_mee/index.dart';
import 'package:flutter/material.dart';

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
    listsdocWidget(),
    MyprofilWidget()
  ];
  final List<Widget> _pagesAdmin = [
    MenuWidget(),
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
        fixedColor: Color(0xff132137),
        unselectedItemColor: Colors.grey,
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
