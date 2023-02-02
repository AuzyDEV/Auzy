import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:new_mee/apis/User_api.dart';
import 'package:new_mee/home/home_widget.dart';
import 'package:new_mee/index.dart';
import 'package:new_mee/apis/User_api.dart';
import '../components/theme.dart';
import '../components/util.dart';
import '../components/widgets.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(
        context, '/chat',
        //arguments: ChatArguments(message),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Text("...");
  }
}
