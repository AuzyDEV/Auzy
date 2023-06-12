import 'package:flutter/material.dart';
import '../authentification/login/login-controller.dart';
import '../index.dart';
import '../user-profile/profile-model.dart';
import '../user-profile/profile-controller.dart';
import '../themes/theme.dart';

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

int selectedIndex = 0;
String _futureStringValue;
ProfilingMan apiUser = ProfilingMan();
Future<User> _futureUser;
ProfilingMan api = ProfilingMan();
SigninMan sapi = SigninMan();

class _DrawerrState extends State<Drawerr> {
  Future<String> _getCurrentUserRole() async {
    return apiUser.GetCurrentUserRole();
  }

  void _getFutureStringValue() async {
    String value = await _getCurrentUserRole();
    setState(() {
      _futureStringValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _futureUser = api.GetCurrentUser();
    _getFutureStringValue();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    height: 130,
                    child: Column(
                      mainAxisSize: MainAxisSize.max, 
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 35, 16, 0),
                          child: FutureBuilder<User>(
                            future: _futureUser,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data.displayName}',
                                            style: FlutterAppTheme.of(context).title1.override(
                                              fontFamily: 'Roboto',
                                              color: FlutterAppTheme.of(context).blackColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB( 0, 5, 0, 0),
                                            child: Text(
                                              '${snapshot.data.email}',
                                              style: FlutterAppTheme.of(context).title1.override(
                                                fontFamily: 'Roboto',
                                                color: FlutterAppTheme.of(context).primaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return Center(
                                child: const CircularProgressIndicatorWidget(
                                  color: Colors.transparent,
                                )
                              );
                            }
                          ),
                        ),
                        Divider()
                      ]
                    ),
                  ),
                ),
              ],
            ),
            _createDrawerItem(context,
              icon: Icons.home_outlined,
              text: 'Home',
              isSelected: selectedIndex == 0, 
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeWidget(),
                  ),
                );
              }
            ),
            if (_futureStringValue == "admin")
              _createDrawerItem(context,
                icon: Icons.people_alt_outlined,
                text: 'User Management',
                isSelected: selectedIndex == 1, 
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => usersnewWidget(),
                    ),
                  );
                }
              ),
            if (_futureStringValue == "admin")
              _createDrawerItem(context,
                icon: Icons.send_outlined,
                text: 'Announcement',
                isSelected: selectedIndex == 2, 
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => announcementWidget(),
                    ),
                  );
                }
              ),
            if (_futureStringValue == "admin")
              _createDrawerItem(context,
                icon: Icons.co_present_outlined,
                text: 'Post Management',
                isSelected: selectedIndex == 3, 
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => postsNewWidget(),
                    ),
                  );
                }
              ),
            if (_futureStringValue == "user")
              _createDrawerItem(context,
                icon: Icons.co_present_outlined,
                text: 'Posts',
                isSelected: selectedIndex == 4, 
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => postsForUsersWidget(),
                    ),
                  );
                }
              ),
            if (_futureStringValue == "user" || _futureStringValue == "admin") 
            _createDrawerItem(context,
                icon: Icons.person_search_outlined,
                text: 'Professionals',
                isSelected: selectedIndex == 5, 
                onTap: () {
                  setState(() {
                    selectedIndex = 5;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpecialitiesWidget(),
                    ),
                  );
                }
              ),
            if (_futureStringValue == "user") 
            _createDrawerItem(context,
              icon: Icons.wechat_outlined,
              text: 'Live Assistant',
              isSelected: selectedIndex == 6, 
              onTap: () {
                setState(() {
                  selectedIndex = 6;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversationsAssistantsListWidget(),
                  ),
                );
              }
            ),
            if (_futureStringValue == "user")
              _createDrawerItem(context,
                icon: Icons.email_outlined,
                text: 'Contact Us',
                isSelected: selectedIndex == 7, 
                onTap: () {
                  setState(() {
                    selectedIndex = 7;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => contactUsWidget(),
                    ),
                  );
                }
              ),
            if (_futureStringValue == "admin")
              _createDrawerItem(context,
                icon: Icons.list,
                text: 'Doctor\'s specialities',
                isSelected: selectedIndex == 8, 
                onTap: () {
                  setState(() {
                    selectedIndex = 8;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListingCategoryForAdmin(),
                    ),
                  );
                }
              ),
            if (_futureStringValue == "assistant")
              _createDrawerItem(context,
                icon: Icons.wechat_outlined,
                text: 'Chats',
                isSelected: selectedIndex == 10, 
                onTap: () {
                  setState(() {
                    selectedIndex = 10;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConversationListUsersForAssistantWidget(),
                    ),
                  );
                }
              ),
            _createDrawerItem(context,
              icon: Icons.account_circle_outlined,
              text: 'Profil',
              isSelected: selectedIndex == 9, 
              onTap: () {
                setState(() {
                  selectedIndex = 9;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyprofilWidget(),
                  ),
                );
              }
            ),
            _createDrawerItem(
              context,
              icon: Icons.logout_outlined,
              text: 'Logout',
              isSelected: selectedIndex == 11,
              onTap: () async {
                bool response = await sapi.LogoutUser();
                if (response)
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninWidget(),
                    ),
                  );
                  setState(() {
                    selectedIndex = 11;
                  });
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerItem(BuildContext context, {IconData icon, String text, GestureTapCallback onTap, bool isSelected}) {
  return Ink(
    child: ListTile(
      selected: true,
      title: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: isSelected
                ? FlutterAppTheme.of(context).primaryColor
                : FlutterAppTheme.of(context).LightDarkTextColor,
              size: 24,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: isSelected
                    ? FlutterAppTheme.of(context).primaryColor
                    : FlutterAppTheme.of(context).LightDarkTextColor),
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    ),
  );
}
