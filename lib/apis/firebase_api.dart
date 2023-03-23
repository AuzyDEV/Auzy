import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_mee/models/Message.dart';
import 'package:http/http.dart' as http;
import '../utils.dart';

class FirebaseApi {
  /*static Stream<List<Userr>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserrField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Userr.fromJson));*/

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
    // final refUsers = FirebaseFirestore.instance.collection('users');
    /* await refUsers
        .doc(idUser)
        .update({UserrField.lastMessageTime: DateTime.now()});*/
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  /* static Future addRandomUsers(List<Userr> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUserr: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }*/

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
}
