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
      final userId = jsonDecode(response1.body);
      String uid = userId["message"][0]['uid'];
      final response2 =
          await http.get(Uri.parse('http://localhost:3000/api/posts/${uid}'));
      if (response2.statusCode == 200) {
        final posts = jsonDecode(response2.body);
        final postsList = posts["message"]["posts"];
        return postsList.map<Post>((json) => Post.fromMapy(json)).toList();
      } else {
        throw Exception("Failed to get post's list");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
