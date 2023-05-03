import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:skeleton/social-post/all-posts/all-posts-model.dart';

class EditPostMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<Post> Postslist;

  Future<Post> getPostDetails(String id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/post/${id}'));
    if (response.statusCode == 200) {
      final post = jsonDecode(response.body);
      return Post.fromMaq(post);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> UpdatePostInfos(String id, String title, contenu) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/post/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'contenu': jsonEncode(contenu),
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFilePostFromDownloadURL(String downloadURL) async {
    final http.Response response =
        await http.delete(Uri.parse('http://127.0.0.1:3000/api/filepost'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'downloadURL': downloadURL,
            }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
