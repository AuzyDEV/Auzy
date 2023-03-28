import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/common_widgets/Button_widget.dart';
import 'package:new_mee/common_widgets/appBar.dart';
import 'package:new_mee/common_widgets/drawer.dart';
import 'package:new_mee/home/home_widget.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/themes/theme.dart';
import 'package:new_mee/common_widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../common_widgets/floatingActionButton_widget.dart';

class UsersWidget extends StatefulWidget {
  const UsersWidget({Key key}) : super(key: key);

  @override
  _UsersWidgetState createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List empsFiltered = [];
  String _searchResult = '';
  int _currentSortColumn = 0;
  bool _isSortAsc = true;
  UserMan api = UserMan();
  bool _isEditMode = false;
  TextEditingController searchController = TextEditingController();
  void _loadData() async {
    await api.GetAllUsers();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Users'),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: floatingActionButtonWidget(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => addUserWidget(),
            ),
          );
        },
        icon: Icons.add,
      ),
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: Color(0xFF9457FB),
                    ),
                    title: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            _searchResult = value;
                            empsFiltered = UserMan.Userslist.where((e) =>
                                e.email.contains(_searchResult.toLowerCase()) ||
                                e.displayName.contains(
                                    _searchResult.toLowerCase())).toList();
                            //print(empsFiltered);
                            //print(_searchResult);
                          });
                        }),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                          _searchResult = '';
                          empsFiltered = UserMan.Userslist;
                        });
                      },
                    ),
                  ),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _createDataTable(),
                    )),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 30, 16, 10),
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: buttonWidget(
                                onPressed: () async {
                                  var confirmDialogResponse = await showDialog<
                                          bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Delete user'),
                                            content: Text(
                                                'Are you sure to delete this user ?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () => {
                                                  api.deleteAllUsers(),
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeWidget(),
                                                    ),
                                                  ),
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                          'Successfully Users deleted!',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            Colors.red),
                                                  ),
                                                },
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                                },
                                text: 'Delete all users',
                              ),
                            ),
                          ),
                        ])),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isSortAsc,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(
        label: Text('Email'),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            if (_isSortAsc) {
              empsFiltered.sort((a, b) => b.email.compareTo(a.email));
            } else {
              empsFiltered.sort((a, b) => a.email.compareTo(b.email));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
      DataColumn(label: Text('Action'))
    ];
  }

  List<DataRow> _createRows() {
    return empsFiltered
        .map((e) =>
            // e.disabled.toString() == "false" ?
            DataRow(
              color: MaterialStateColor.resolveWith((states) {
                if (e.disabled.toString() == "true") {
                  return Colors.red[50];
                } else
                  return Colors.white;
              }),
              cells: [
                DataCell(Text('#' + e.id.toString())),
                _createTitleCell(e.email.toString()),
                DataCell(
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 10, 8),
                      child: Row(children: [
                        InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfillWidget(id: e.id.toString()),
                              ),
                            );
                          },
                          child: Container(
                            width: 40,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.blue[50],
                                width: 0,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Delete user'),
                                            content: Text(
                                                'Are you sure to delete this user ?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () => {
                                                  api.deleteUser(
                                                      e.id.toString()),
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UsersWidget(),
                                                    ),
                                                  ),
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                          'Successfully User deleted!',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                        backgroundColor:
                                                            Colors.red),
                                                  ),
                                                },
                                                child: Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                            },
                            child: Container(
                              width: 40,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 210, 207),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color.fromARGB(255, 245, 210, 207),
                                  width: 0,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                child: Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 163, 32, 23),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => editprofilWidget(
                                      id: e.id.toString(),
                                      name: e.displayName,
                                      email: e.email,
                                      photourl: e.photoURL.toString()),
                                ),
                              );
                            },
                            child: Container(
                              width: 40,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(214, 241, 228, 200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                child: Icon(
                                  Icons.update,
                                  color: Color.fromARGB(255, 214, 116, 36),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        e.disabled.toString() == "false"
                            ? Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('block user'),
                                                  content: Text(
                                                      'Are you sure to block this user ?'),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () => {
                                                        api.BlockUser(
                                                            e.id.toString()),
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeWidget(),
                                                          ),
                                                        ),
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                'Successfully User blocked!',
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
                                                                  Colors.red),
                                                        ),
                                                      },
                                                      child: Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.red[100],
                                        width: 0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 4, 4, 4),
                                      child: Icon(
                                        Icons.block,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('restore user'),
                                                  content: Text(
                                                      'Are you sure to restore this user ?'),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () => {
                                                        api.RestoreUser(
                                                            e.id.toString()),
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeWidget(),
                                                          ),
                                                        ),
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                'Successfully User restored!',
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
                                                                  Colors.red),
                                                        ),
                                                      },
                                                      child: Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.green[50],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.green[50],
                                        width: 0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 4, 4, 4),
                                      child: Icon(
                                        Icons.repeat_rounded,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ])),
                ),
              ],
            ))
        .toList();
  }

  DataCell _createTitleCell(bookTitle) {
    return DataCell(_isEditMode == true
        ? TextFormField(initialValue: bookTitle, style: TextStyle(fontSize: 14))
        : Text(bookTitle));
  }

  Row _createCheckboxField() {
    return Row(
      children: [
        Checkbox(
          value: _isEditMode,
          onChanged: (value) {
            setState(() {
              _isEditMode = value;
            });
          },
        ),
        Text('Edit mode'),
      ],
    );
  }
}
