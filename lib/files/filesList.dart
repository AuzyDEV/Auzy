import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/components/appBar.dart';
import 'package:new_mee/components/drawer.dart';
import 'package:new_mee/files/addFileToDrive_widget.dart';
import 'package:new_mee/files/filedetails.dart';
import 'package:new_mee/home/home_widget.dart';
import 'package:new_mee/models/File.dart';
import 'package:flutter/material.dart';
import 'package:new_mee/apis/fileMan.dart';
import 'package:new_mee/components/theme.dart';

class FileWidget extends StatefulWidget {
  const FileWidget({Key key}) : super(key: key);

  @override
  _FileWidgetState createState() => _FileWidgetState();
}

UserMan api = UserMan();
fileMan apiFile = fileMan();
String uid;
Future<List<File>> _futureFiles;
Future<String> _getUserID() async {
  uid = await api.GetIDCurrentUser();
  return uid;
}

class _FileWidgetState extends State<FileWidget> {
  @override
  void initState() {
    super.initState();
    _getUserID();
    _futureFiles = apiFile.fetchDownloadUrls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Files'),
      ),
      drawer: Drawerr(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addFileToDriveWidget(),
            ),
          );
          //print(uid);
          /*final metadata = SettableMetadata(
            //contentType: 'image/jpg',
            customMetadata: {'uid': uid},
          );
          FilePickerResult result = await FilePicker.platform.pickFiles();
          //print(result);
          try {
            if (result != null) {
              Uint8List fileBytes = result.files.first.bytes;
              String fileName = result.files.first.name;

              // Upload file
              await FirebaseStorage.instance
                  .ref('$fileName')
                  .putData(fileBytes, metadata);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                    'Successfully file added!',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  duration: Duration(milliseconds: 4000),
                  backgroundColor: Colors.red),
            );
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FileWidget(),
              ),
            );
          } catch (e) {
            print(e);
          }
*/
          /*    fileMan api = fileMan();

          var picked = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf']);
          io.Directory tempDir = await getApplicationDocumentsDirectory();
          String tempPath = tempDir.path;
          print(tempPath);
          if (picked != null) {
            bool response = await api.uploadFileeeeee(
                context, picked.files.first.name, io.File(tempPath));
            //print(response);
            if (response == true)
              print("heelllooooo");
            else {
              print("noooo");
            }
          }*/
          /*await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addUserWidget(),
            ),
          );*/
        },
        backgroundColor: Color(0xFF101213),
        elevation: 2,
        child: Icon(
          Icons.add,
          color: FlutterFlowTheme.of(context).primaryBtnText,
          size: 24,
        ),
      ),
      body: FutureBuilder<List<File>>(
        future: _futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 7, mainAxisSpacing: 7),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
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
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data[index].downloadURL,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                            child: Text(
                              snapshot.data[index].name,
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                          Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                              child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FileDetailsWidget(
                                                    name: snapshot
                                                        .data[index].name,
                                                    downloadURL: snapshot
                                                        .data[index]
                                                        .downloadURL),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 35,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[50],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.blue[50],
                                            width: 0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 4, 4, 4),
                                          child: Icon(
                                            Icons.visibility_outlined,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          //print(snapshot.data[index].downloadURL);
                                          fileMan api = fileMan();
                                          api.donwloadFile(
                                              snapshot.data[index].downloadURL);
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.blue[50],
                                              width: 0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4, 4, 4, 4),
                                            child: Icon(
                                              Icons.download_outlined,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          var confirmDialogResponse =
                                              await showDialog<bool>(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      fileMan api = fileMan();
                                                      return AlertDialog(
                                                        title:
                                                            Text('Delete file'),
                                                        content: Text(
                                                            'Are you sure to delete this file ?'),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext,
                                                                    false),
                                                            child:
                                                                Text('Cancel'),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () => {
                                                              api.deleteFile(
                                                                  snapshot
                                                                      .data[
                                                                          index]
                                                                      .name),
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MenuWidget(),
                                                                ),
                                                              ),
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Successfully file deleted!',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            4000),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red),
                                                              ),
                                                            },
                                                            child:
                                                                Text('Confirm'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ) ??
                                                  false;
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 247, 221, 218),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4, 4, 4, 4),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("URL"),
                                                  content: SelectableText(
                                                    "${snapshot.data[index].downloadURL}",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                    showCursor: true,
                                                    cursorWidth: 5,
                                                    cursorColor: Colors.green,
                                                    cursorRadius:
                                                        Radius.circular(5),
                                                    toolbarOptions:
                                                        ToolbarOptions(
                                                            copy: true),
                                                    scrollPhysics:
                                                        ClampingScrollPhysics(),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.amber[50],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.amber[50],
                                              width: 0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4, 4, 4, 4),
                                            child: Icon(
                                              Icons.link_outlined,
                                              color: Colors.amber,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    /*  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        //print(snapshot.data[index].downloadURL);
                                        fileMan api = fileMan();
                                        api.donwloadFile(
                                            snapshot.data[index].downloadURL);
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.amber[50],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color:
                                                Color.fromARGB(255, 50, 55, 58),
                                            width: 0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 4, 4, 4),
                                          child: Icon(
                                            Icons.link,
                                            color: Colors.amber,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                               */
                                  ])),
                          /*  Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("URL"),
                                                content: SelectableText(
                                                  "${snapshot.data[index].downloadURL}",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                  showCursor: true,
                                                  cursorWidth: 5,
                                                  cursorColor: Colors.green,
                                                  cursorRadius:
                                                      Radius.circular(5),
                                                  toolbarOptions:
                                                      ToolbarOptions(
                                                          copy: true),
                                                  scrollPhysics:
                                                      ClampingScrollPhysics(),
                                                ),
                                                actions: [
                                                  FlatButton(
                                                    child: Text("Ok"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.amber[50],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.amber[50],
                                            width: 0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 4, 4, 4),
                                          child: Icon(
                                            Icons.link,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),*/
                        ]),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("no data"),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}




/*
class FileWidget extends StatefulWidget {
  final String id, name, email, photourl;
  const FileWidget({Key key, this.id, this.email, this.name, this.photourl})
      : super(key: key);

  @override
  _FileWidgetState createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  final List<String> downloadUrls = [
    "https://firebasestorage.googleapis.com/v0/b/myfirstapp-72a20.appspot.com/o/example_1674145271926.jpg?alt=media&token=ad2bbd86-171b-4318-b37c-84bf65159386",
    "https://firebasestorage.googleapis.com/v0/b/myfirstapp-72a20.appspot.com/o/Screenshot%20Capture%20-%202023-01-13%20-%2012-38-41.png?alt=media&token=e6b898a2-fd2d-4905-9867-33044caae74e"
  ];
  fileMan api = fileMan();
  void _loadData() async {
    await api.getAllFilesofSpecificUser();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    print(fileMan.fileslist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: downloadUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<dynamic>(
            future: FirebaseStorage.instance
                .refFromURL(downloadUrls[index])
                .getDownloadURL(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                //_loadData();
                //  print(fileMan.fileslist);
                // print(fileMan.fileslist.length);
                // print(snapshot.data.toString());
                return Image.network(snapshot.data.toString());
              } else {
                if (snapshot.hasError) {
                  return Text(snapshot.error);
                }
                return CircularProgressIndicator();
              }
            },
          );
        },
      ),
    );
  }
}
*/
