import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import '../index.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String stringValue;
  int numberUsers;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Home'),
      ),
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(18, 10, 0, 0),
                              child: Row(
                                children: [
                                  Text("Find a doctor",
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily:'Roboto',
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),  
                            Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 120,
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              await Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AllListingsWidget(
                                                    speciality:
                                                        "Neurologist",
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                    child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFF1F4F8),
                                                          boxShadow: [
                                                            BoxShadow( blurRadius: 0, color: Color(0x340F1113),
                                                            )
                                                          ],
                                                          shape: BoxShape.circle,
                                                        ),
                                                        alignment: AlignmentDirectional(0, 0),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                          child: Image.asset(
                                                            'assets/images/image_(1).png',
                                                            width: 35,
                                                            height: 35,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:  MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Text('Neurologist',
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => AllListingsWidget( speciality:"Ophtalmologist",),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                    child:InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFF1F4F8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 0,
                                                              color: Color(0x340F1113),
                                                            )
                                                          ],
                                                          shape: BoxShape.circle,
                                                        ),
                                                        alignment: AlignmentDirectional(0, 0),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                          child: Image.asset(
                                                            'assets/images/image_(8).png',
                                                            width: 35,
                                                            height: 35,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:  MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Text('Ophtalmologist',
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) => AllListingsWidget( speciality: "Psychiatrist",),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              child: Column(
                                                mainAxisSize:  MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                    child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFF1F4F8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 0,
                                                              color: Color(0x340F1113),
                                                            )
                                                          ],
                                                          shape: BoxShape.circle,
                                                        ),
                                                        alignment: AlignmentDirectional(0, 0),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                          child: Image.asset(
                                                            'assets/images/image_(4).png',
                                                            width: 35,
                                                            height: 35,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Text('Psychiatrist',
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) => AllListingsWidget(speciality: "Orthopdist",),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration:
                                                BoxDecoration(
                                                  color: Colors.transparent,
                                              ),
                                              child: Column(
                                                mainAxisSize:  MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                    child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFF1F4F8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 0,
                                                              color: Color(0x340F1113),
                                                            )
                                                          ],
                                                          shape: BoxShape.circle,
                                                        ),
                                                        alignment: AlignmentDirectional(0, 0),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                          child: Image.asset(
                                                            'assets/images/image_(9)(1).png',
                                                            width: 35,
                                                            height: 35,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:  MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                          child: Text('Orthopdist',
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) => SpecialitiesWidget(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration:
                                                BoxDecoration(
                                                  color: Colors.transparent,
                                                ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 6),
                                                    child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      focusColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFF1F4F8),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 0,
                                                              color: Color(0x340F1113),
                                                            )
                                                          ],
                                                          shape: BoxShape.circle,
                                                        ),
                                                        alignment: AlignmentDirectional(0, 0),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                                                          child: Icon(
                                                            Icons.keyboard_control,
                                                            color: Colors.black,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                          child: Text('See all',
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    )
                                  )
                                ]
                              ),
                            ),  
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(18, 10, 0, 8),
                              child: Row(
                                children: [
                                  Text( "Discover our guidance",
                                    style: FlutterAppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),  
                          PostsListingWidget(),
                          ]
                         )
                      ),
                    ]
                  ),  
                )
              ],
            ),
          )
        )
      )
    );
  }
}
