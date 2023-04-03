import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dart_ipify/dart_ipify.dart';

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
    final data = jsonDecode(response.body);
    return data['message'];
  }
}
