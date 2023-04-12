import 'dart:convert';

import 'package:new_mee/social-post/all-posts/file-model.dart';

List<savedPost> savedPostFromJson(String str) =>
    List<savedPost>.from(json.decode(str).map((x) => savedPost.fromMap(x)));

class savedPost {
  String id;
  String postTitle;
  String uid, postContenu, date, uname, uphoto, currentUserId, visibility;
  List<dynamic> files;
  savedPost(
      {this.id,
      this.postTitle,
      this.postContenu,
      this.date,
      this.uname,
      this.uphoto,
      this.currentUserId,
      this.uid,
      this.visibility,
      this.files});

  factory savedPost.fromMap(Map<String, dynamic> json) {
    return savedPost(
      id: (json["id"] ?? ''),
      postTitle: (json["postTitle"] ?? ''),
      postContenu: (json["postContenu"] ?? ''),
      date: (json["date"] ?? ''),
      uname: (json["uname"] ?? ''),
      uphoto: (json["uphoto"] ?? ''),
      currentUserId: (json["currentUserId"] ?? ''),
    );
  }
  factory savedPost.fromMaq(Map<String, dynamic> json) {
    return savedPost(
      id: (json["id"] ?? ''),
      postTitle: (json["data"]["title"] ?? ''),
      postContenu: (json["data"]["contenu"] ?? ''),
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
}
