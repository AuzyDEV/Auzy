import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dart_ipify/dart_ipify.dart';

import 'package:new_mee/user-profile/profile-model.dart';

class ProfilUserMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<User> Userslist;
  static String role;

  Future<User> GetUser(String id) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:3000/api/userinfoswithipadress/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print(data[0]["ipadress"]);
      return User.fromMapp(data[0]);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<String> GetUserIPAdress(String id) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:3000/api/userinfoswithipadress/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[0]["ipadress"];
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
