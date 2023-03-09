import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_mee/models/Post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:new_mee/models/sharedPost.dart';

class sharedPostMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> SharePost(
      String postId,
      postContenu,
      String postPhoto,
      String adminName,
      String adminPhoto,
      String currentUserId,
      String currentUserName,
      String currentUserphoto,
      String idSharedUser) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/sharepost'),
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
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else if (response.statusCode == 404) {
      return false;
    }
  }

  Future<List<sharedPost>> getAllSharedPostsByCurrentUserId() async {
    final response1 =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response1.statusCode == 200) {
      final data1 = jsonDecode(response1.body);
      String uid = data1[0]['uid'];

      final response = await http
          .get(Uri.parse('http://localhost:3000/api/sharedposts/${uid}'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        //print(parsed["posts"]);
        //print(parsed);
        var data = parsed["sharedposts"];

        return data
            .map<sharedPost>((json) => sharedPost.fromMap(json))
            .toList();
      } else {
        throw Exception("Failed to get saved post's list");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
