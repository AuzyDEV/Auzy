import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'conversation-model.dart';
import 'package:http/http.dart' as http;
import '../../utils/utils.dart';

class MessageMan {
  static Future uploadMessage(String idUser, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$idUser/messages');
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newMessage = Message(
        idUser: data[0]['uid'],
        urlAvatar: data[0]['photoURL'],
        username: data[0]['displayName'],
        message: message,
        createdAt: DateTime.now(),
      );
      await refMessages.add(newMessage.toJson());
    }
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future<Stream<List<Message>>> getAllMessages(String idUser) async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/msg/${idUser}'));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print(parsed);
      return parsed.map<Message>((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get children's list");
    }
  }

  Future<int> getNbrMessages(String id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/nbr/${id}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int nbr = data["length"];
      return nbr;
    } else {
      throw Exception("Failed to get children's list");
    }
  }
}
