import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../../../Posts/PostsModel/Post.dart';

class PostMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<Post> Postslist;

  Future<List> GetAllPostsManagement() async {
    Postslist = new List<Post>();
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/posts'));
    if (response.statusCode == 200) {
      // List<dynamic> body = jsonDecode(response.body);
      List body = jsonDecode(response.body);
      //print(body);
      for (int i = 0; i < body.length; i++) {
        Postslist.add(new Post.fromMapi(body[i]));
      }
    } else {
      throw Exception("Failed to upload posts list");
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

  Future<Post> getPostDetails(String id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/post/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data[0]);
      //print(Post.fromMappp(data[0]));
      return Post.fromMaq(data);
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
