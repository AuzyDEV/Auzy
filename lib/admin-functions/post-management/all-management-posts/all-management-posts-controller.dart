import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:skeleton/social-post/all-posts/all-posts-model.dart';

class PostMan {
  static List<Post> Postslist;

  Future<List> GetAllPostsManagement() async {
    Postslist = new List<Post>();
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/posts'));
    if (response.statusCode == 200) {
      var posts = jsonDecode(response.body);
      List postsList = posts["message"];
      for (int i = 0; i < postsList.length; i++) {
        Postslist.add(new Post.fromMapi(postsList[i]));
      }
    } else {
      throw Exception("Failed to upload posts list");
    }
  }

  Future<List<Post>> getAllListingsNew() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/postsnew'));
    if (response.statusCode == 200) {
      final listings = jsonDecode(response.body);
      final allListings = listings["message"]["listCollections"];
      return allListings.map<Post>((json) => Post.fromMapis(json)).toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }

  Future<bool> deletePost(String id) async {
    final http.Response response =
        await http.delete(Uri.parse('http://127.0.0.1:3000/api/post/${id}'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> RestorePost(String id) async {
    final response = await http.put(
        Uri.parse('http://127.0.0.1:3000/api/postvisibilitytrue/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> HidePost(String id) async {
    final response = await http.put(
        Uri.parse('http://127.0.0.1:3000/api/postvisibilityfalse/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
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
