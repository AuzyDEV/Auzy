import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dart_ipify/dart_ipify.dart';

class CreateAccountMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, String>> signupUser(
    String email,
    String password,
    String displayName,
  ) async {
    final ipv4 = await Ipify.ipv4();
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'displayName': displayName,
        'photoURL':
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhG_cZjxXIlwfsjseD7-LMSMzWI7txguoSLjCbwM85&s",
        'ipadress': ipv4,
      }),
    );
    final userData = jsonDecode(response.body);
    final res = userData["message"];
    final createdAccount = res.cast<String, String>();
    return createdAccount;
  }
}
