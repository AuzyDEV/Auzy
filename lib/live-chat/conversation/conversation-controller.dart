import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../user-profile/profile-model.dart';
import 'conversation-model.dart';
import 'package:http/http.dart' as http;
import '../../utils/utils.dart';

class MessageMan {
  static Future uploadMessage(String assistantId, String message, String currentUserId) async {
    final refMessages = FirebaseFirestore.instance.collection('chats/$currentUserId/discussions/$assistantId/messages');
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final responseDiscu = await http.post(Uri.parse('http://127.0.0.1:3000/api/addiscuAssi/$assistantId/$currentUserId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
      final user = jsonDecode(response.body);
      final newMessage = Message(
        idUser: user["message"][0]['uid'],
        urlAvatar: user["message"][0]['photoURL'],
        username: user["message"][0]['displayName'],
        message: message,
        createdAt: DateTime.now(),
      );
      await refMessages.add(newMessage.toJson());
    }
  }

  static Future uploadMessageForAssistant(String currentUserId, String assistantId, String message) async {
    final refMessages = FirebaseFirestore.instance.collection('chats/$currentUserId/discussions/$assistantId/messages');
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final responseDiscu = await http.post(Uri.parse('http://127.0.0.1:3000/api/addiscuAssi/$assistantId/$currentUserId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
      final user = jsonDecode(response.body);
      final newMessage = Message(
        idUser: user["message"][0]['uid'],
        urlAvatar: user["message"][0]['photoURL'],
        username: user["message"][0]['displayName'],
        message: message,
        createdAt: DateTime.now(),
      );
      await refMessages.add(newMessage.toJson());
    }
  }

  static Stream<List<Message>> getMessages(String idAssistant, String currentUserId) =>
    FirebaseFirestore.instance.collection('chats/$currentUserId/discussions/$idAssistant/messages').orderBy(MessageField.createdAt, descending: true).snapshots().transform(Utils.transformer(Message.fromJson));

  static Future<Stream<List<Message>>> getAllMessages(String idUser) async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/msg/${idUser}'));
    if (response.statusCode == 200) {
      final messages = jsonDecode(response.body);
      return messages.map<Message>((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get children's list");
    }
  }

  static Stream<List<Message>> getMessagesForAssistans(String currentUserId, String idAssistant) =>
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
