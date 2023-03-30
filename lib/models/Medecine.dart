import 'dart:convert';
import 'File.dart';


List<Medecine> MedecineFromJson(String str) =>
    List<Medecine>.from(json.decode(str).map((x) => Medecine.fromMap(x)));

class Medecine {
  String id;
  String name, type, desciption, price;
  String productionDate, expDate;
  List<dynamic> files;
  Medecine(
      {this.id,
      this.name,
      this.type,
      this.price,
      this.desciption,
      this.productionDate,
      this.expDate,
      this.files});

  factory Medecine.fromMap(Map<String, dynamic> json) {
    return Medecine(
      id: (json["id"] ?? ''),
      name: (json["data"]["name"] ?? ''),
      type: (json["data"]["type"] ?? ''),
      desciption: (json["data"]["desciption"] ?? ''),
      productionDate: DateTime.fromMillisecondsSinceEpoch(
              (json["data"]["productionDate"]["seconds"] * 1000 +
                  json["data"]["productionDate"]["nanoseconds"] ~/ 1000000))
          .toString(),
      expDate: DateTime.fromMillisecondsSinceEpoch(
              (json["data"]["expDate"]["seconds"] * 1000 +
                  json["data"]["expDate"]["nanoseconds"] ~/ 1000000))
          .toString(),
      files: List<File>.from(json["files"].map((x) => File.fromMap(x))),
    );
  }
  factory Medecine.fromMaq(Map<String, dynamic> json) {
    return Medecine(
      name: (json["data"]["name"] ?? ''),
      type: (json["data"]["type"] ?? ''),
      desciption: (json["data"]["desciption"] ?? ''),
      productionDate: DateTime.fromMillisecondsSinceEpoch(
              (json["data"]["productionDate"]["seconds"] * 1000 +
                  json["data"]["productionDate"]["nanoseconds"] ~/ 1000000))
          .toString(),
      expDate: DateTime.fromMillisecondsSinceEpoch(
              (json["data"]["expDate"]["seconds"] * 1000 +
                  json["data"]["expDate"]["nanoseconds"] ~/ 1000000))
          .toString(),
      files: List<File>.from(json["files"].map((x) => File.fromMaq(x))),
    );
  }
  factory Medecine.fromMapdrug(Map<String, dynamic> json) {
    return Medecine(
      id: (json["id"] ?? ''),
      name: (json["data"]["name"] ?? ''),
      type: (json["data"]["type"] ?? ''),
      price: (json["data"]["price"] ?? ''),
      desciption: (json["data"]["desciption"] ?? ''),
      files: List<File>.from(json["files"].map((x) => File.fromMap(x))),
    );
  }
  factory Medecine.fromMaqdrug(Map<String, dynamic> json) {
    return Medecine(
      name: (json["data"]["name"] ?? ''),
      type: (json["data"]["type"] ?? ''),
      price: (json["data"]["price"] ?? ''),
      desciption: (json["data"]["desciption"] ?? ''),
      files: List<File>.from(json["files"].map((x) => File.fromMaq(x))),
    );
  }
}
