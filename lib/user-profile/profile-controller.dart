import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skeleton/user-profile/profile-model.dart';

class ProfilingMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String role;

  Future<User> GetCurrentUser() async {
    final response1 =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response1.statusCode == 200) {
      final currentUser = jsonDecode(response1.body);
      String userId = currentUser["message"][0]['uid'];
      final response2 = await http
          .get(Uri.parse('http://127.0.0.1:3000/api/userinfos/${userId}'));
      if (response2.statusCode == 200) {
        final currentUserDetails = jsonDecode(response2.body);
        final currentUserDetail = currentUserDetails["message"][0];
        return User.fromMapp(currentUserDetail);
      } else {
        throw Exception("Failed to get infos");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<String> GetCurrentUserRole() async {
    final response1 =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response1.statusCode == 200) {
      final currentUser = jsonDecode(response1.body);
      String userId = currentUser["message"][0]['uid'];
      final response2 = await http
          .get(Uri.parse('http://127.0.0.1:3000/api/userole/${userId}'));
      if (response2.statusCode == 200) {
        final currentUserRole = jsonDecode(response2.body);
        role = currentUserRole["message"][0];
        return role;
      } else {
        throw Exception("Failed to get infos");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<String> GetIDCurrentUser() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String uid = data["message"][0]['uid'];
      return uid;
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> DeleteCurrentUser() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String uid = data["message"][0]['uid'];
      print(data[0]['uid']);
      //User.fromMapp(data[0]);
      final http.Response response1 = await http
          .delete(Uri.parse('http://127.0.0.1:3000/api/userinfo/${uid}'));

      if (response1.statusCode == 200) {
        return true;
      } else {
        return false;
      }
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
      print(data["message"]);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ChangePassword(String password) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/userpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
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

  Future<bool> BlockCurrentUser() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String uid = data["message"][0]['uid'];
      //return User.fromMapp(data[0]);
      final response1 = await http.put(
          Uri.parse('http://127.0.0.1:3000/api/blocuser/${uid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response1.statusCode == 200) {
        final data1 = jsonDecode(response1.body);
        print(data1);
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
