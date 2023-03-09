import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_mee/models/Medecine.dart';

class DBMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addNewDrug(
    String name,
    String type,
    String price,
    String desciption,
  ) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/addDB'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'type': type,
        'price': price,
        'desciption': desciption,
        'collectionName': "drugs"
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      //print(data);
      String drugId = data["id"];
      return drugId;
    } else {
      throw Exception("Failed to get infos");
    }
  }

  Future<List<Medecine>> getAllDrugs() async {
    String collectionName = "drugs";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["listCollections"];
      return data.map<Medecine>((json) => Medecine.fromMapdrug(json)).toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }

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
}
