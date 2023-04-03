import 'dart:convert';

import 'package:new_mee/social-post/all-posts/File.dart';
import '../../utils/util.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  String id;
  String title;
  String contenu,
      date,
      uname,
      uphoto,
      visibility,
      uid,
      existsInCollection2,
      downloadURL;
  List<dynamic> files;
  Post(
      {this.id,
      this.title,
      this.contenu,
      this.date,
      this.uname,
      this.uphoto,
      this.visibility,
      this.uid,
      this.files,
      this.existsInCollection2,
      this.downloadURL});
  factory Post.fromMap(Map<String, dynamic> json) {
    return Post(
      title: (json["title"] ?? ''),
      contenu: (json["contenu"] ?? ''),
    );
  }
  factory Post.fromMapp(Map<String, dynamic> json) {
    return Post(
      id: (json["id"] ?? ''),
      title: (json["data"]["title"] ?? ''),
      contenu: (json["data"]["contenu"] ?? ''),
      date: DateTime.fromMillisecondsSinceEpoch(
              (json["data"]["date"]["seconds"] * 1000 +
                  json["data"]["date"]["nanoseconds"] ~/ 1000000))
          .toString(),
      uname: (json["data"]["uname"] ?? ''),
      uphoto: (json["data"]["uphoto"] ?? ''),
      uid: (json["data"]["uid"] ?? ''),
      visibility: (json["visibility"] ?? '').toString(),
      files: List<File>.from(json["files"].map((x) => File.fromMap(x))),
    );
  }
  factory Post.fromMapy(Map<String, dynamic> json) {
    return Post(
      id: (json["id"] ?? ''),
      title: (json["data"]["title"] ?? ''),
      contenu: (json["data"]["contenu"] ?? ''),
      date: DateFormat('dd MMM yyyy HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(
              (json["data"]["date"]["seconds"] * 1000 +
                  json["data"]["date"]["nanoseconds"] ~/ 1000000)))
          .toString(),
      uname: (json["data"]["uname"] ?? ''),
      uphoto: (json["data"]["uphoto"] ?? ''),
      uid: (json["data"]["uid"] ?? ''),
      visibility: (json["visibility"] ?? '').toString(),
      existsInCollection2: (json["existsInCollection2"] ?? '').toString(),
      downloadURL: (json["downloadURL"] ?? ''),
    );
  }
  factory Post.fromMaq(Map<String, dynamic> json) {
    return Post(
      title: (json["data"]["title"] ?? ''),
      contenu: (json["data"]["contenu"] ?? ''),
      date: DateFormat('dd MMM yyyy HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(
              (json["data"]["date"]["seconds"] * 1000 +
                  json["data"]["date"]["nanoseconds"] ~/ 1000000)))
          .toString(),
      uname: (json["data"]["uname"] ?? ''),
      uphoto: (json["data"]["uphoto"] ?? ''),
      uid: (json["data"]["uid"] ?? ''),
      visibility: (json["visibility"] ?? '').toString(),
      files: List<File>.from(json["files"].map((x) => File.fromMaq(x))),
    );
  }
  factory Post.fromMappp(Map<String, dynamic> json) {
    return Post(
      title: (json["title"] ?? ''),
      contenu: (json["contenu"] ?? ''),
      date: DateTime.fromMillisecondsSinceEpoch(
              (json["date"]["seconds"] * 1000 +
                  json["date"]["nanoseconds"] ~/ 1000000))
          .toString() /*(json["date"]["seconds"] ?? 'haifa').toString()*/,
      uname: (json["uname"] ?? ''),
      uphoto: (json["uphoto"] ?? ''),
      visibility: (json["visibility"] ?? '').toString(),
    );
  }
  factory Post.fromMapi(Map<String, dynamic> json) {
    return Post(
      id: (json["id"] ?? ''),
      title: (json["title"] ?? ''),
      contenu: (json["contenu"] ?? ''),
      date: DateTime.fromMillisecondsSinceEpoch(
              (json["date"]["seconds"] * 1000 +
                  json["date"]["nanoseconds"] ~/ 1000000))
          .toString(),
      uname: (json["uname"] ?? ''),
      uphoto: (json["uphoto"] ?? ''),
      visibility: (json["visibility"] ?? '').toString(),
    );
  }
  static Post fromJson(Map<String, dynamic> json) => Post(
        id: (json["uid"] ?? ''),
        title: (json["title"] ?? ''),
        contenu: (json["contenu"] ?? ''),
      );
}
