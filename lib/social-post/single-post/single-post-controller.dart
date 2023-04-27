import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:skeleton/social-post/all-posts/all-posts-model.dart';

class SinglePostMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<Post> Postslist;

  Future<Post> getPostDetails(String id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/post/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print(Post.fromMappp(data[0]));
      print(data["message"]);
      return Post.fromMaq(data["message"]);
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
