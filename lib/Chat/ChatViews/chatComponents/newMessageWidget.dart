import 'package:flutter/material.dart';
import 'package:new_mee/themes/theme.dart';
import '../../ChatController/messagesMan.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;

  const NewMessageWidget({
    @required this.idUser,
    Key key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';
  bool isShowSticker;
  void sendMessage() async {
    FocusScope.of(context).unfocus();
    await MessageMan.uploadMessage(widget.idUser, message);
    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    isShowSticker = false;
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
      Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Container(
          color: FlutterAppTheme.of(context).whiteColor,
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Material(
                child: InkWell(
                  onTap: () async {
                    return showModalBottomSheet(
                      context: context,
                      builder: (BuildContext subcontext) {
                        return Container(
                          height: 266,
                        );
                      },
                    );
                  },
                  child: new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 1.0),
                    child: new IconButton(
                      icon: new Icon(Icons.face),
                   
                      color: FlutterAppTheme.of(context).TransparentColor,
                    ),
                  ),
                ),
                color: FlutterAppTheme.of(context).whiteColor,
              ),
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
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    message = value;
                  }),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: message.trim().isEmpty ? null : sendMessage,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FlutterAppTheme.of(context).tertiaryColor,
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
      ]);
}
