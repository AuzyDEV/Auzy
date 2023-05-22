import 'dart:convert';

List<File> postFromJson(String str) =>
    List<File>.from(json.decode(str).map((x) => File.fromMap(x)));

class File {
  String id;
  String name;
  String downloadURL, contentType, size, timeCreated, updated;
  File(
    {this.id,
    this.name,
    this.downloadURL,
    this.contentType,
    this.size,
    this.timeCreated,
    this.updated});
  factory File.fromMap(Map<String, dynamic> json) {
    return File(
      name: (json["name"] ?? ''),
      downloadURL: (json["downloadURL"] ?? ''),
    );
  }
  factory File.fromMaq(Map<String, dynamic> json) {
    return File(
      downloadURL: (json["downloadURL"] ?? ''),
    );
  }
  factory File.fromMapp(Map<String, dynamic> json) {
    return File(
      name: (json["name"] ?? ''),
      downloadURL: (json["downloadURL"] ?? ''),
      contentType: (json["contentType"] ?? ''),
      size: (json["size"] ?? ''),
      timeCreated: (json["timeCreated"] ?? ''),
      updated: (json["updated"] ?? ''),
    );
  }
  static File fromJson(Map<String, dynamic> json) => 
    File(
      id: (json["uid"] ?? ''),
      name: (json["name"] ?? ''),
      downloadURL: (json["downloadURL"] ?? ''),
    );
}
