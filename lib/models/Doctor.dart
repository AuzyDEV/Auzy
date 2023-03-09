import 'dart:convert';

import 'package:new_mee/models/File.dart';

import '../components/util.dart';

List<Doctor> DoctorFromJson(String str) =>
    List<Doctor>.from(json.decode(str).map((x) => Doctor.fromMap(x)));

class Doctor {
  String id;
  String firstName, lastName, speciality;
  String email, phoneNumber, Adress;
  List<dynamic> files;
  Doctor(
      {this.id,
      this.firstName,
      this.lastName,
      this.speciality,
      this.email,
      this.phoneNumber,
      this.Adress,
      this.files});

  factory Doctor.fromMap(Map<String, dynamic> json) {
    return Doctor(
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
  factory Doctor.fromMaq(Map<String, dynamic> json) {
    return Doctor(
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
