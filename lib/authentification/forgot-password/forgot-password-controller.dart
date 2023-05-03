import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> resetpasswordUser(
    String email,
  ) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/resetemail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    final responseMessage = jsonDecode(response.body);
    return responseMessage['message'];
  }
}
