import 'dart:convert';
import 'package:skeleton/social-post/all-posts/file-model.dart';

List<ListingCtegoryModel> ListingCtegoryModelFromJson(String str) =>
    List<ListingCtegoryModel>.from(
        json.decode(str).map((x) => ListingCtegoryModel.fromMap(x)));

class ListingCtegoryModel {
  String id;
  String Name;
  List<dynamic> files;
  ListingCtegoryModel({this.id, this.Name, this.files});

  factory ListingCtegoryModel.fromMap(Map<String, dynamic> json) {
    return ListingCtegoryModel(
      id: (json["id"] ?? ''),
      Name: (json["data"]["Name"] ?? ''),
      files: List<File>.from(json["files"].map((x) => File.fromMap(x))),
    );
  }
}
