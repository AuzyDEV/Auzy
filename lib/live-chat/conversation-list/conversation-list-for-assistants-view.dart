import '../../index.dart';
import '../../user-profile/profile-controller.dart';
import '../../user-profile/profile-model.dart';
import 'package:flutter/material.dart';
import '../conversation/conversation-controller.dart';
import '../conversation/conversation-for-assistants-view.dart';

class ConversationListUsersForAssistantWidget extends StatefulWidget {
  const ConversationListUsersForAssistantWidget({Key key}) : super(key: key);

  @override
  _ConversationListUsersForAssistantWidgetState createState() => _ConversationListUsersForAssistantWidgetState();
}

class _ConversationListUsersForAssistantWidgetState extends State<ConversationListUsersForAssistantWidget> {
  String searchString = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController;
  Future<List<User>> futurePost;
  String value, value1;
  MessageMan MessageServices = MessageMan();
  String _CurrentUserId;
  ProfilingMan profilingUserServices = ProfilingMan();

  Future<String> _getCurrentUserId() async {
    return profilingUserServices.GetIDCurrentUser();
  }

  void _getFutureStringValue() async {
    String value = await _getCurrentUserId();
    setState(() {
      _CurrentUserId = value;
    });
  }
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _getFutureStringValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appbar(text: 'Live Assistant'),
      ),
      drawer: Drawerr(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                      child: FutureBuilder<List<User>>(
                                        future: MessageServices.getAllUsersBySpecifiedAssistant(_CurrentUserId),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final users = snapshot.data;
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (BuildContext context, index) {
                                                return Container(
                                                  height: 75,
                                                  child: ListTile(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                            ChatPageForAssistant( user: users[index]),
                                                        )
                                                      );
                                                    },
                                                    leading: Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage:
                                                        NetworkImage("https://fac.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2FFAC.2Fvar.2Ffemmeactuelle.2Fstorage.2Fimages.2Famour.2Fcoaching-amoureux.2Fcest-quoi-belle-femme-temoignages-43206.2F14682626-1-fre-FR.2Fc-est-quoi-une-belle-femme-temoignages.2Ejpg/1200x1200/quality/80/crop-from/center/c-est-quoi-une-belle-femme-temoignages.jpeg"),
                                                        ),
                                                        Positioned(
                                                          top: 35,
                                                          right: 0,
                                                          child: Container(
                                                            width: 10,
                                                            height: 10,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.green, 
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    title: Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(users[index].displayName),
                                                          Padding(
                                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Text(
                                                              "Online",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors.green,
                                                              ),
                                                            )
                                                          )
                                                        ],
                                                      )
                                                    )
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text("no users!");
                                          }
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: const CircularProgressIndicatorWidget(),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
