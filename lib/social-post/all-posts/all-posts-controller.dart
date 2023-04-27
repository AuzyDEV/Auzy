import 'package:firebase_auth/firebase_auth.dart';
import 'all-posts-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PostsUserMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<Post> Postslist;
  Future<List<Post>> getAllPostsForUsers() async {
    final response1 =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response1.statusCode == 200) {
      final data1 = jsonDecode(response1.body);
      String uid = data1["message"][0]['uid'];
      final response =
          await http.get(Uri.parse('http://localhost:3000/api/saved/${uid}'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        //print(parsed["posts"]);
        final data = parsed["message"]["posts"];
        return data.map<Post>((json) => Post.fromMapy(json)).toList();
      } else {
        throw Exception("Failed to get post's list");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
