import 'dart:convert';

import 'package:new_mee/models/File.dart';

import '../components/util.dart';

List<sharedPost> sharedPostFromJson(String str) =>
    List<sharedPost>.from(json.decode(str).map((x) => sharedPost.fromMap(x)));

class sharedPost {
  String id,
      postId,
      postContenu,
      postPhoto,
      adminName,
      adminPhoto,
      currentUserId,
      currentUserName,
      currentUserphoto,
      idSharedUser,
      dateShare;

  sharedPost(
      {this.id,
      this.postId,
      this.postContenu,
      this.postPhoto,
      this.adminName,
      this.adminPhoto,
      this.currentUserId,
      this.currentUserName,
      this.currentUserphoto,
      this.idSharedUser,
      this.dateShare});

  factory sharedPost.fromMap(Map<String, dynamic> json) {
    return sharedPost(
      id: (json["id"] ?? ''),
      postId: (json["postId"] ?? ''),
      postContenu: (json["postContenu"] ?? ''),
      postPhoto: (json["postPhoto"] ?? ''),
      adminName: (json["adminName"] ?? ''),
      adminPhoto: (json["adminPhoto"] ?? ''),
      currentUserId: (json["currentUserId"] ?? ''),
      currentUserName: (json["currentUserName"] ?? ''),
      currentUserphoto: (json["currentUserphoto"] ?? ''),
      idSharedUser: (json["idSharedUser"] ?? ''),
      dateShare: DateTime.fromMillisecondsSinceEpoch(
              (json["dateShare"]["seconds"] * 1000 +
                  json["dateShare"]["nanoseconds"] ~/ 1000000))
          .toString(),
    );
  }
}
