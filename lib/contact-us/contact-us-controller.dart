import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class EmailMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> ContactUsWithEmail(
      String email, String name, String mobile, String message) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'name': name,
        'mobile': mobile,
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
