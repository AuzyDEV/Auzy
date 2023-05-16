import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:skeleton/user-profile/profile-model.dart';

class ProfilUserMan {
  static List<User> Userslist;
  static String role;

  Future<User> GetUser(String id) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:3000/api/userinfoswithipadress/${id}'));
    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      return User.fromMapp(userData["message"][0]);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<String> GetUserIPAdress(String id) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:3000/api/userinfoswithipadress/${id}'));
    if (response.statusCode == 200) {
      final userDataWithIp = jsonDecode(response.body);
      return userDataWithIp["message"][0]["ipadress"];
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
