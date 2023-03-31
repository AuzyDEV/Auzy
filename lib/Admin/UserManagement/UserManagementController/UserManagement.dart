import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dart_ipify/dart_ipify.dart';

import '../../../Profiling/ProfilingModel/User.dart';

class UserMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<User> Userslist;
  static String role;

  Future<List> GetAllUsers() async {
    // ignore: deprecated_member_use
    Userslist = new List<User>();
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/get'));
    if (response.statusCode == 200) {
      // List<dynamic> body = jsonDecode(response.body);
      List body = jsonDecode(response.body);
      for (int i = 0; i < body.length; i++) {
        Userslist.add(new User.fromMappp(body[i]));
      }
    } else {
      throw Exception("Failed to upload product list");
    }
  }
 Future<int> CountNumberOfUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/getnumberofusers'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int nbr = data["count"];
      return nbr;
    } else {
      throw Exception("Failed to get children's list");
    }
  }

  Future<bool> deleteUser(String id) async {
    final http.Response response = await http
        .delete(Uri.parse('http://127.0.0.1:3000/api/userinfo/${id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAllUsers() async {
    final http.Response response = await http
        .delete(Uri.parse('http://127.0.0.1:3000/api/deleteallusers'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

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

  Future<bool> UpdateprofilUser(
      String id, String email, String displayName, String photoURL) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/userinfo/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'displayName': displayName,
        'photoURL': photoURL,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<List<User>> GetAllUsersForChats() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/get'));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed.map<User>((json) => User.fromMapp(json)).toList();
    } else {
      throw Exception("Failed to get children's list");
    }
  }

  Future<bool> BlockUser(String id) async {
    final response = await http.put(
        Uri.parse('http://127.0.0.1:3000/api/blocuser/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> RestoreUser(String id) async {
    final response = await http.put(
        Uri.parse('http://127.0.0.1:3000/api/restoreuser/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<List<User>> getAllUsersRole() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/usersrole'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      //print(parsed);
      var data = parsed["users"];
      //print(data);
      return data.map<User>((json) => User.fromMapy(json)).toList();
    } else {
      throw Exception("Failed to get saved post's list");
    }
  }
  
}
