import 'dart:html';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:new_mee/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dart_ipify/dart_ipify.dart';

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
