import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skeleton/user-profile/profile-model.dart';

class UserMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<User> Userslist;
  static String role;

  Future<List> GetAllUsers() async {
    Userslist = new List<User>();
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/get'));
    if (response.statusCode == 200) {
      var users = jsonDecode(response.body);
      List usersList = users["message"];
      for (int i = 0; i < usersList.length; i++) {
        Userslist.add(new User.fromMappp(usersList[i]));
      }
    } else {
      throw Exception("Failed to upload product list");
    }
  }

  Future<int> CountNumberOfUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/getnumberofusers'));

    if (response.statusCode == 200) {
      final numberUsers = jsonDecode(response.body);
      int numberOfUsers = numberUsers["count"];
      return numberOfUsers;
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
      return true;
    } else {
      return false;
    }
  }

  Future<List<User>> GetAllUsersForChats() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/get'));

    if (response.statusCode == 200) {
      final usersList = jsonDecode(response.body);
      return usersList.map<User>((json) => User.fromMapp(json)).toList();
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
      return true;
    } else {
      return false;
    }
  }

  Future<List<User>> getAllUsersRole() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/usersrole'));
    if (response.statusCode == 200) {
      final listUsersRole = jsonDecode(response.body);
      var usersRoles = listUsersRole["message"]["users"];
      return usersRoles.map<User>((json) => User.fromMapy(json)).toList();
    } else {
      throw Exception("Failed to get saved post's list");
    }
  }
}
