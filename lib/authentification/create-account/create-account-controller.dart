import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dart_ipify/dart_ipify.dart';

class CreateAccountMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signupUser(String email, String password, String displayName,
      String photoURL) async {
    final ipv4 = await Ipify.ipv4();
    final http.Response response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/ipadress'));
    if (response.statusCode == 200) {
      final response1 = await http.post(
        Uri.parse('http://127.0.0.1:3000/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'displayName': displayName,
          'photoURL': photoURL,
          'ipadress': ipv4,
        }),
      );
      final userData = jsonDecode(response1.body);
      return userData['message'];
    }
  }
}
