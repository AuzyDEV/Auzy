import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AnnoucementMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> sendBroadcastEmail(String message) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/sendbroadmail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'message': message,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
