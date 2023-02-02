import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/apis/fileMan.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/models/File.dart';
import 'package:new_mee/models/User.dart';
import 'package:new_mee/components/theme.dart';
import 'package:new_mee/components/util.dart';
import 'package:new_mee/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FileDetailsWidget extends StatefulWidget {
  final String name, downloadURL;
  const FileDetailsWidget({Key key, this.name, this.downloadURL})
      : super(key: key);

  @override
  _FileDetailsWidgetState createState() => _FileDetailsWidgetState();
}

class _FileDetailsWidgetState extends State<FileDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  fileMan api = fileMan();
  Future<File> _futureFile;
  @override
  void initState() {
    super.initState();
    _futureFile = api.GetFileByName(widget.name);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'File details'),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<File>(
              future: _futureFile,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x230E151B),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  widget.downloadURL,
                                  width: double.infinity,
                                  height: 270,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                                child: Text(
                                  widget.name,
                                  style: FlutterFlowTheme.of(context).subtitle1,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                                child: Text(
                                  "Content type: " + snapshot.data.contentType,
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                                child: Text(
                                  "Created & updated Time: " +
                                      snapshot.data.timeCreated +
                                      " " +
                                      snapshot.data.updated,
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                                child: Text(
                                  "File Size: " + snapshot.data.size,
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicator());
              })),
    );
  }
}
