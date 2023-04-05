import 'dart:convert';
import 'package:new_mee/admin-functions/post-management/add-post/add-post-view.dart';
import 'package:new_mee/admin-functions/post-management/all-management-posts/all-management-posts-controller.dart';
import 'package:new_mee/user-profile/profile-controller.dart';
import 'package:flutter/material.dart';

import 'package:new_mee/home/home-view.dart';
import 'package:new_mee/social-post/single-post/single-post-view.dart';
import '../../../themes/alert-popup.dart';
import '../../../themes/app-bar-widget.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/floating-button-widget.dart';
import '../../../themes/left-drawer.dart';
import '../../../themes/loading-spinner.dart';
import '../../../themes/snack-bar-widget.dart';
import '../../../themes/theme.dart';
import '../../../themes/theme.dart';
import '../edit-post/edit-post-view.dart';

class PostsManagementWidget extends StatefulWidget {
  const PostsManagementWidget({Key key}) : super(key: key);

  @override
  _PostsManagementWidgetState createState() => _PostsManagementWidgetState();
}

class _PostsManagementWidgetState extends State<PostsManagementWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List empsFiltered = [];
  String _searchResult = '';
  int _currentSortColumn = 0;
  bool _isSortAsc = true;
  PostMan api = PostMan();
  ProfilingMan apiUser = ProfilingMan();
  bool _isEditMode = false;
  String role;
  TextEditingController searchController = TextEditingController();
  void _loadData() async {
    await api.GetAllPostsManagement();
  }

  Future<String> _getCurrentUserRole() async {
    this.role = await apiUser.GetCurrentUserRole();
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
        child: appbar(text: 'Posts'),
      ),
      backgroundColor: FlutterAppTheme.of(context).whiteColor,
      floatingActionButton: floatingActionButtonWidget(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addNewPostWidget()),
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
                            empsFiltered = PostMan.Postslist.where((e) =>
                                e.title.contains(_searchResult.toLowerCase()) ||
                                e.contenu.contains(
                                    _searchResult.toLowerCase())).toList();
                          });
                        }),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                      ),
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                          _searchResult = '';
                          empsFiltered = PostMan.Postslist;
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
                  children: [],
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
        label: Text('Title'),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            if (_isSortAsc) {
              empsFiltered.sort((a, b) => b.title.compareTo(a.title));
            } else {
              empsFiltered.sort((a, b) => a.title.compareTo(b.title));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
      DataColumn(label: Text('Text')),
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Action'))
    ];
  }

  List<DataRow> _createRows() {
    return empsFiltered
        .map((e) => DataRow(
              color: MaterialStateColor.resolveWith((states) {
                if (e.visibility.toString() == "false") {
                  return Colors.red[50];
                } else
                  return Colors.green[50];
              }),
              cells: [
                DataCell(Text('#' + e.id.toString())),
                _createTitleCell(e.title.toString()),
                DataCell(Text("post ")
                    // Html(data: e.contenu.toString()),
                    ),
                _createTitleCell(e.date.toString()),
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
                                    postDetailsWidget(id: e.id.toString()),
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
                                Icons.remove_red_eye_outlined,
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
                                          return alertDialogWidget(
                                            title: 'Delete post',
                                            content:
                                                'Are you sure to delete this post ?',
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => {
                                                  api.deletePost(
                                                      e.id.toString()),
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeWidget(),
                                                    ),
                                                  ),
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackbarWidget(
                                                      content: Text(
                                                        'Successfully post deleted!',
                                                      ),
                                                    ),
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
                                  builder: (context) => editPostDetailsWidget(
                                    id: e.id.toString(),
                                    title: e.title,
                                    contenu: e.contenu,
                                  ),
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
                        e.visibility.toString() == "true"
                            ? Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return alertDialogWidget(
                                                  title: 'Hide post',
                                                  content:
                                                      'Are you sure to hide this post ?',
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {
                                                        api.HidePost(
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
                                                                SnackbarWidget(
                                                          content: Text(
                                                            'Successfully post hide!',
                                                          ),
                                                        )),
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
                                        Icons.lock_outline,
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
                                                return alertDialogWidget(
                                                  title: 'restore post',
                                                  content:
                                                      'Are you sure to restore this post ?',
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {
                                                        api.RestorePost(
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
                                                          SnackbarWidget(
                                                            content: Text(
                                                              'Successfully post restored!',
                                                            ),
                                                          ),
                                                        )
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
                                        Icons.remove_red_eye_outlined,
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
