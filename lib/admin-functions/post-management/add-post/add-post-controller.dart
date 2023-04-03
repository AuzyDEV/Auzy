import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:new_mee/social-post/all-posts/all-posts-model.dart';

class AddPostMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<Post> Postslist;

  Future<String> addNewPost(
      String title, contenu, String uid, String uname, String uphoto) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/addpost'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'contenu': jsonEncode(contenu),
        'uid': uid,
        'uname': uname,
        'uphoto': uphoto,
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      //print(data);
      print(data["id"]);
      String PostId = data["id"];
      return PostId;
    } else {
      throw Exception("Failed to get infos");
    }
  }
}
