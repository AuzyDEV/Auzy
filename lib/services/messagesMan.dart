import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class MessageMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
