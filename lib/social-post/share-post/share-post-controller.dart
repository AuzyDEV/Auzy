import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'share-post-model.dart';

class sharedPostMan {

  Future<bool> SharePost(String postId, String postContenu, String postPhoto, String adminName, String adminPhoto, String currentUserId, String currentUserName, String currentUserphoto, String idSharedUser) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:3000/api/sharepost'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'postId': postId,
        'postContenu': postContenu,
        'postPhoto': postPhoto,
        'adminName': adminName,
        'adminPhoto': adminPhoto,
        'currentUserId': currentUserId,
        'currentUserName': currentUserName,
        'currentUserphoto': currentUserphoto,
        'idSharedUser': idSharedUser
      }),
    );
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    }
  }

  Future<List<sharedPost>> getAllSharedPostsByCurrentUserId() async {
    final responseuser = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (responseuser.statusCode == 200) {
      final user = jsonDecode(responseuser.body);
      String userId = user["message"][0]['uid'];
      final response = await http.get(Uri.parse('http://localhost:3000/api/sharedposts/${userId}'));

      if (response.statusCode == 200) {
        final sharedPosts = jsonDecode(response.body);
        var sharedPostsList = sharedPosts["message"]["sharedposts"];
        return sharedPostsList.map<sharedPost>((json) => sharedPost.fromMap(json)).toList();
        
      } else {
        throw Exception("Failed to get saved post's list");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
