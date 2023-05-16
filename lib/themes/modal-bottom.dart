import '../admin-functions/user-management/profil-user/profil-user-controller.dart';
import '../index.dart';
import '../themes/theme.dart';
import 'package:flutter/material.dart';

class ShowIpAdressWidget extends StatefulWidget {
  final String id;
  const ShowIpAdressWidget({Key key, this.id}) : super(key: key);

  @override
  _ShowIpAdressWidgetState createState() => _ShowIpAdressWidgetState();
}

class _ShowIpAdressWidgetState extends State<ShowIpAdressWidget> {
  ProfilUserMan api = ProfilUserMan();
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
                      style: FlutterAppTheme.of(context).bodyText1.override(
                            color: Colors.black,
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
              return Center(child: CircularProgressIndicatorWidget());
            }));
  }
}
