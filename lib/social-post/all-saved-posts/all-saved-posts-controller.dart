import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../all-posts/all-posts-model.dart';
import 'dart:convert';
import 'dart:async';
import 'all-saved-posts-model.dart';

class SavedPostMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<Post> Postslist;

  Future<bool> DeleteSavedPost(String id) async {
    final http.Response response = await http
        .delete(Uri.parse('http://127.0.0.1:3000/api/savedpost/${id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<savedPost>> getAllSavedPostsForUsers(String currentUserId) async {
    final response = await http.get(
        Uri.parse('http://localhost:3000/api/savedposts/${currentUserId}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      //print(parsed);
      var data = parsed["posts"];
      //print(data);
      return data.map<savedPost>((json) => savedPost.fromMaq(json)).toList();
    } else {
      throw Exception("Failed to get saved post's list");
    }
  }

  Future<bool> SavePost(String postId, String postTitle,  postContenu,
      String date, String uname, String uphoto, String currentUserId) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/savepost'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'postId': postId,
        'postTitle': postTitle,
        'postContenu': jsonEncode(postContenu),
        'date': date,
        'uname': uname,
        'uphoto': uphoto,
        'currentUserId': currentUserId
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<int> countSavedPosts(String currentUserId) async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:3000/api/countsavedPosts/zIaox7kij7NcdPBX3mHgQKJbwIw1'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int nbr = data["count"];
      //print(nbr);
      return nbr;
    } else {
      throw Exception("Failed to get saved posts list");
    }
  }
}
