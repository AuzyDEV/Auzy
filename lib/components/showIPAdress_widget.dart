import 'package:new_mee/apis/User_api.dart';

import '../components/theme.dart';
import '../components/util.dart';
import '../components/widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ShowIpAdressWidget extends StatefulWidget { 
  final String id;
  const ShowIpAdressWidget({Key key, this.id}) : super(key: key);

  @override
  _ShowIpAdressWidgetState createState() => _ShowIpAdressWidgetState();
}

class _ShowIpAdressWidgetState extends State<ShowIpAdressWidget> {
  UserMan api = UserMan();
  Future<String> _futureUser;
  @override
  void initState() {
    super.initState();
    _futureUser = api.GetUserIPAdress(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
        ),
        child: FutureBuilder<String>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '${snapshot.data}',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
                return Center(
                              child: const CircularProgressIndicator());
            }));
  }
}
