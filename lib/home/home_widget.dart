import 'package:flutter_svg/svg.dart';
import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/components/drawer.dart';
import 'package:new_mee/index.dart';
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

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String stringValue;
  int numberUsers;
  final TextEditingController _controller = TextEditingController();
  Future<int> getnbrUsers() async {
    numberUsers = await api.CountNumberOfUsers();
    //print(numberUsers);
    return numberUsers;
  }

  EmojiData _emojiData;
  Future<User> _futureUser;
  UserMan api = UserMan();
  @override
  void initState() {
    super.initState();
    _futureUser = api.GetCurrentUser();
    getnbrUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appbar(text: 'Home'),
        ),
        backgroundColor: Colors.white,
        drawer: Drawerr(),
        //  bottomNavigationBar: buttomNavBar()
        body: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
                  child: SingleChildScrollView(
                    child: FutureBuilder<User>(
                        future: _futureUser,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 15, 0, 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Welcome',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 20,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 2, 0, 0),
                                              child: Text(
                                                '${snapshot.data.displayName}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 5),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE0E3E7),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 2, 2, 2),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  '${snapshot.data.photoURL}',
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 12,
                                    indent: 50,
                                    endIndent: 50,
                                    color: Colors.grey[150],
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 5),
                                      child: Wrap(
                                        spacing:
                                            8.0, // gap between adjacent chips
                                        runSpacing: 8.0, // gap between lines
                                        children: <Widget>[
                                          Container(
                                            color: Colors.grey[50],
                                            width: 160,
                                            height: 160,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 12, 12),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.people,
                                                    color: Colors.red,
                                                    size: 44,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 12, 0, 12),
                                                    child: Text(
                                                      '${numberUsers}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Total Users',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 160,
                                            height: 160,
                                            color: Colors.grey[50],
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 12, 12),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.message,
                                                    color: Colors.amber,
                                                    size: 44,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 12, 0, 12),
                                                    child: Text(
                                                      '\$320k',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Total Messages',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 160,
                                            height: 160,
                                            color: Colors.grey[50],
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 12, 12),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.notifications,
                                                    color: Colors.green,
                                                    size: 44,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 12, 0, 12),
                                                    child: Text(
                                                      '\$320k',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Total things',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 160,
                                            height: 160,
                                            color: Colors.grey[50],
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 12, 12),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.block,
                                                    color: Colors.blue,
                                                    size: 44,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 12, 0, 12),
                                                    child: Text(
                                                      '\$320k',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Total Interactions',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                      /*   Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 30, 16, 10),
                                    child: Row(children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              String response =
                                                  await api.pushNotification();
                                              print(response);
                                              response == "notification send!"
                                                  ? showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title:
                                                              Text("Succes!"),
                                                          content: Text(
                                                              "Notif send"),
                                                          actions: [
                                                            FlatButton(
                                                              child: Text("ok"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      })
                                                  : showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text("Error"),
                                                          content:
                                                              Text("$response"),
                                                          actions: [
                                                            FlatButton(
                                                              child: Text("Ok"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                            },
                                            text: 'submit',
                                            options: FFButtonOptions(
                                              height: 45,
                                              color: Color(0xff132137),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily: 'Roboto',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBtnText,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])),
                             */
                                      /*  Center(
                                    child: Expanded(
                                  child: Container(
                                    height: 80,
                                    color: Colors.green,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 30,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                                'https://media.gettyimages.com/id/1294339577/fr/photo/jeune-belle-femme.jpg?s=612x612&w=gi&k=20&c=fKueH-U1UzEEwIvHXX88vMt8FmGhKWv3jz7lFZfn9R8=',
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                                'https://media.gettyimages.com/id/1294339577/fr/photo/jeune-belle-femme.jpg?s=612x612&w=gi&k=20&c=fKueH-U1UzEEwIvHXX88vMt8FmGhKWv3jz7lFZfn9R8=',
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                              */
                                      ),
                                  /*  Container(
                                      child: SfPdfViewer.network(
                                          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                                          canShowScrollHead: false,
                                          canShowScrollStatus: false))
*/
                                  /*  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        child: Text(
                                          _emojiData == null
                                              ? 'No emoji selected'
                                              : 'Selected ${_emojiData.char}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'Apple Color Emoji',
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                          top: 30,
                                        ),
                                      ),
                                      EmojiChooser(
                                        onSelected: (emoji) {
                                          setState(() {
                                            _emojiData = emoji;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                               */
                                ]);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.
                          return Center(
                              child: const CircularProgressIndicator());
                        }),
                  ),
                ))));
  }
}
