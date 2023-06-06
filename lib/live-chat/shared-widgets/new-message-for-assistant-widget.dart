import 'package:flutter/material.dart';
import '../../themes/theme.dart';
import '../../user-profile/profile-controller.dart';
import '../conversation/conversation-controller.dart';

class NewMessageForAssistantWidget extends StatefulWidget {
  final String idUser;

  const NewMessageForAssistantWidget({ @required this.idUser, Key key,}) : super(key: key);

  @override
  _NewMessageForAssistantWidgetState createState() => _NewMessageForAssistantWidgetState();
}

class _NewMessageForAssistantWidgetState extends State<NewMessageForAssistantWidget> {
  final _controller = TextEditingController();
  String message = '';
  bool isShowSticker;
  ProfilingMan profilingUserServices = ProfilingMan();
  String _CurrentUserId;

  Future<String> _getCurrentUserId() async {
    return profilingUserServices.GetIDCurrentUser();
  }

  void _getFutureStringValue() async {
    String value = await _getCurrentUserId();
    print("assistant id = "+ value);
    setState(() {
      _CurrentUserId = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getFutureStringValue();
    print(widget.idUser);
    isShowSticker = false;
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    await MessageMan.uploadMessageForAssistant(widget.idUser, _CurrentUserId, message);
    _controller.clear();
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.end, 
      children: <Widget>[
        Container(
          color: FlutterAppTheme.of(context).whiteColor,
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: FlutterAppTheme.of(context).lightGrey,
                    labelText: 'Type your message',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    message = value;
                  }),
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: message.trim().isEmpty ? null : sendMessage,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.send,
                    color: FlutterAppTheme.of(context).whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]
    );
}
