import 'dart:convert';

import 'package:new_mee/social-post/all-posts/File.dart';

List<ListingModel> ListingModelFromJson(String str) => List<ListingModel>.from(
    json.decode(str).map((x) => ListingModel.fromMap(x)));

class ListingModel {
  String id;
  String firstName, lastName, speciality;
  String email, phoneNumber, Adress;
  List<dynamic> files;
  ListingModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.speciality,
      this.email,
      this.phoneNumber,
      this.Adress,
      this.files});

  factory ListingModel.fromMap(Map<String, dynamic> json) {
    return ListingModel(
      id: (json["id"] ?? ''),
      firstName: (json["data"]["firstName"] ?? ''),
      lastName: (json["data"]["lastName"] ?? ''),
      speciality: (json["data"]["speciality"] ?? ''),
      email: (json["data"]["email"] ?? ''),
      phoneNumber: (json["data"]["phoneNumber"] ?? ''),
      Adress: (json["data"]["Adress"] ?? ''),
      files: List<File>.from(json["files"].map((x) => File.fromMap(x))),
    );
  }
  factory ListingModel.fromMaq(Map<String, dynamic> json) {
    return ListingModel(
      firstName: (json["data"]["firstName"] ?? ''),
      lastName: (json["data"]["lastName"] ?? ''),
      speciality: (json["data"]["speciality"] ?? ''),
      email: (json["data"]["email"] ?? ''),
      phoneNumber: (json["data"]["phoneNumber"] ?? ''),
      Adress: (json["data"]["Adress"] ?? ''),
      files: List<File>.from(json["files"].map((x) => File.fromMaq(x))),
    );
  }
}
