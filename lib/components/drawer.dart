import 'dart:js';
import 'package:flutter/material.dart';
import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/chat/chats_copy.dart';
import 'package:new_mee/components/theme.dart';
import 'package:new_mee/files/filesList.dart';
import 'package:new_mee/index.dart';

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

int selectedIndex = 0;

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            /* Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 55, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                      child: Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/auzy.png',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(130, 0, 0, 0),
                  ),
                ],
              ),
            ),*/
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 140, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Welcome,',
                    style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Roboto',
                          color: Color(0xFF090F13),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 5, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'To Our Flutter Application',
                    style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Roboto',
                          color: Color(0xFF090F13),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 40,
              indent: 1,
            ),
            _createDrawerItem(
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
                      builder: (context) => MenuWidget(),
                    ),
                  );
                }),
            _createDrawerItem(
                icon: Icons.account_circle_outlined,
                text: 'My Profil',
                isSelected: selectedIndex == 1,
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyprofilWidget(),
                    ),
                  );
                }),
            _createDrawerItem(
                icon: Icons.people_alt_outlined,
                text: 'User Management',
                isSelected: selectedIndex == 2,
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsersWidget(),
                    ),
                  );
                }),
            _createDrawerItem(
                icon: Icons.message_outlined,
                text: 'Messages',
                isSelected: selectedIndex == 3,
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => chatcopyWidget(),
                    ),
                  );
                }),
            _createDrawerItem(
                icon: Icons.image_outlined,
                text: 'File Management',
                isSelected: selectedIndex == 4,
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileWidget(),
                    ),
                  );
                }),
            _createDrawerItem(
                icon: Icons.email_outlined,
                text: 'Contact Us',
                isSelected: selectedIndex == 5,
                onTap: () {
                  setState(() {
                    selectedIndex = 5;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => contactUsWidget(),
                    ),
                  );
                }),
            _createDrawerItem(
              icon: Icons.logout_outlined,
              text: 'Logout',
              isSelected: selectedIndex == 6,
              onTap: () async {
                UserMan api = UserMan();
                bool response = await api.LogoutUser();
                if (response)
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninWidget(),
                    ),
                  );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap, bool isSelected}) {
  return Ink(
    child: ListTile(
      selected: true,
      hoverColor: Colors.white,
      title: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: isSelected
                  ? Color.fromARGB(255, 214, 116, 36)
                  : Color(0xFF616A6B),
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
                        ? Color.fromARGB(255, 214, 116, 36)
                        : Color(0xFF616A6B)),
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    ),
  );
}
