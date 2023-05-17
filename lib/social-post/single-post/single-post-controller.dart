import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:skeleton/social-post/all-posts/all-posts-model.dart';

class SinglePostMan {
  static List<Post> Postslist;

  Future<Post> getPostDetails(String id) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/post/${id}'));
    if (response.statusCode == 200) {
      final postDetails = jsonDecode(response.body);
      return Post.fromMaq(postDetails["message"]);
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
