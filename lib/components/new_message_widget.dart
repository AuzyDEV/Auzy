import 'package:flutter/material.dart';
import 'package:new_mee/apis/firebase_api.dart';
//import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
//import 'package:emoji_chooser/emoji_chooser.dart';

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
  // EmojiData _emojiData;
  void sendMessage() async {
    FocusScope.of(context).unfocus();
    await FirebaseApi.uploadMessage(widget.idUser, message);
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
          color: Colors.white,
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
                          /*child: EmojiChooser(
                            onSelected: (emoji) {
                              print(emoji.toString());
                              Navigator.of(subcontext).pop(emoji);
                              setState(() {
                                _emojiData = emoji;
                                _controller.text =
                                    _controller.text + _emojiData.char;
                                print(_emojiData.char);
                              });
                            },
                          ),*/
                        );
                      },
                    );
                  },
                  child: new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 1.0),
                    child: new IconButton(
                      icon: new Icon(Icons.face),
                      /*onPressed: () {
                      setState(() {
                        isShowSticker = !isShowSticker;
                      }
                      );
                    },*/
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                color: Colors.white,
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
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
                    color: Colors.blue,
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        /*(isShowSticker ? buildSticker() : Container()),*/
      ]);
}
/*
Widget buildSticker() {
  return EmojiPicker(
      config: Config(
    columns: 7,
    emojiSizeMax: 32 *
        (foundation.defaultTargetPlatform == TargetPlatform.iOS
            ? 1.30
            : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
    verticalSpacing: 0,
    horizontalSpacing: 0,
    gridPadding: EdgeInsets.zero,
    initCategory: Category.RECENT,
    bgColor: Color(0xFFF2F2F2),
    indicatorColor: Colors.blue,
    iconColor: Colors.grey,
    iconColorSelected: Colors.blue,
    backspaceColor: Colors.blue,
    skinToneDialogBgColor: Colors.white,
    skinToneIndicatorColor: Colors.grey,
    enableSkinTones: true,
    showRecentsTab: true,
    recentsLimit: 28,
    noRecents: const Text(
      'No Recents',
      style: TextStyle(fontSize: 20, color: Colors.black26),
      textAlign: TextAlign.center,
    ), // Needs to be const Widget// Needs to be const Widget
    tabIndicatorAnimDuration: kTabScrollDuration,
    categoryIcons: const CategoryIcons(),
    buttonMode: ButtonMode.MATERIAL,
  ));
}*/
