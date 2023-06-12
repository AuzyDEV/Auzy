import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../user-profile/profile-model.dart';
import 'conversation-model.dart';
import 'package:http/http.dart' as http;
import '../../utils/utils.dart';

class MessageMan {

  static Future addNewMessage(String assistantId, String message, String currentUserId) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      await http.post(Uri.parse('http://127.0.0.1:3000/api/addiscuAssi/$assistantId/$currentUserId'),
    );
    final user = jsonDecode(response.body);
    await http.post(Uri.parse('http://127.0.0.1:3000/api/uploadmsg/$currentUserId/$assistantId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'idUser':user["message"][0]['uid'],
        'urlAvatar': user["message"][0]['photoURL'],
        'username': user["message"][0]['displayName'],
        'message': message,
      }),
    );
    } else {
      throw Exception("Failed to upload message");
    }
  }

  static Stream<List<Message>> getMessages(String idAssistant, String currentUserId) =>
    FirebaseFirestore.instance.collection('chats/$currentUserId/discussions/$idAssistant/messages').orderBy(MessageField.createdAt, descending: true).snapshots().transform(Utils.transformer(Message.fromJson));

  Future<List<User>> getAllUsersBySpecifiedAssistant(String AssistantId) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/listusersbyAssi/$AssistantId'));
    if (response.statusCode == 200) {
      final listings = jsonDecode(response.body);
      return listings.map<User>((json) => User.fromM(json)).toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }
}
