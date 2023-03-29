import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:new_mee/services/User_api.dart';
import 'package:new_mee/views/doctors/doctorsListing_widget.dart';
import 'package:new_mee/views/home/home_widget.dart';
import 'package:new_mee/index.dart';

class buttomNavBar extends StatefulWidget {
  @override
  _buttomNavBarState createState() => _buttomNavBarState();
}

int _selectedIndex = 0;
UserMan apiUser = UserMan();

PageController _pageController;
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
String _futureRoleValue;
Future<String> _getCurrentUserRole() async {
  return apiUser.GetCurrentUserRole();
}

void _getFutureRoleValue() async {
  String value = await _getCurrentUserRole();

    _futureRoleValue = value;
  
}

class _buttomNavBarState extends State<buttomNavBar> {
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _getFutureRoleValue();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
 }
}
