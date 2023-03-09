import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_mee/models/Doctor.dart';
import 'package:new_mee/models/Medecine.dart';

class DBDoctorMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addNewDoctor(
      String firstName,
      String lastName,
      String speciality,
      String email,
      String phoneNumber,
      String Adress) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/addDB'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'speciality': speciality,
        'email': email,
        'Adress': Adress,
        'phoneNumber': phoneNumber,
        'collectionName': "doctors"
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      String doctorId = data["id"];
      return doctorId;
    } else {
      throw Exception("Failed to get infos");
    }
  }

  Future<List<Doctor>> getAllDoctors() async {
    String collectionName = "doctors";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["listCollections"];
      return data.map<Doctor>((json) => Doctor.fromMap(json)).toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }

  Future<Doctor> getDoctorDetails(String id) async {
    String collectionName = "doctors";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Doctor.fromMaq(data);
    } else {
      throw Exception("Failed to load infos");
    }
  }

/*
  Future<List<Medecine>> getAllDrugs() async {
    String collectionName = "drugs";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["medecines"];
      return data.map<Medecine>((json) => Medecine.fromMapdrug(json)).toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }*/
/*
  Future<Medecine> getDBDetails(String id) async {
    String collectionName = "drugs";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Medecine.fromMaqdrug(data);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> UpdateDrugInfos(
      String id, String name, String type, String desciption) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/updateDB/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'type': type,
        'desciption': desciption,
        'collectionName': "drugs"
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

  Future<bool> deleteDrug(String id) async {
    String collectionName = "drugs";
    final http.Response response = await http.delete(
        Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}/${id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
*/
}
