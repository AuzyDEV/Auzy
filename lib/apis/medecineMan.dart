import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_mee/models/Medecine.dart';

class medecineMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addNewMedecine(String name, String type, String desciption,
      String productionDate, String expDate) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/addmedecine'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'type': type,
        'desciption': desciption,
        'productionDate': productionDate,
        'expDate': expDate
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      //print(data);
      String medecineId = data["id"];
      return medecineId;
    } else {
      throw Exception("Failed to get infos");
    }
  }

  Future<Medecine> getMedecineDetails(String id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/medecine/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print(data);
      //print(Medecine.fromMappp(data[0]));
      return Medecine.fromMaq(data);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<List<Medecine>> getAllAvailableMedecines() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/medecines'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["medecines"];
      return data.map<Medecine>((json) => Medecine.fromMap(json)).toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }

  Future<bool> UpdateMedecineInfos(String id, String name, String type,
      String desciption, String productionDate, String expDate) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/medecine/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'type': type,
        'desciption': desciption,
        'productionDate': productionDate,
        'expDate': expDate
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

  Future<bool> deleteMedecine(String id) async {
    final http.Response response = await http
        .delete(Uri.parse('http://127.0.0.1:3000/api/medecine/${id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
