import 'all-posts-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PostsUserMan {
  static List<Post> Postslist;
  
  Future<List<Post>> getAllPostsForUsers() async {
    final responseuser = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (responseuser.statusCode == 200) {
      final userId = jsonDecode(responseuser.body);
      String uid = userId["message"][0]['uid'];
      final responsepost = await http.get(Uri.parse('http://localhost:3000/api/posts/${uid}'));
      if (responsepost.statusCode == 200) {
        final posts = jsonDecode(responsepost.body);
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
