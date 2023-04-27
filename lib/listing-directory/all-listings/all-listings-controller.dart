import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../single-listing/single-listing-model.dart';

class AllListingsMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<ListingModel>> getAllDoctors() async {
    String collectionName = "doctors";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["message"]["listCollections"];
      return data
          .map<ListingModel>((json) => ListingModel.fromMap(json))
          .toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }

  Future<List<ListingModel>> getAllDoctorsWithSpeciality(
      String speciality) async {
    String collectionName = "doctors";
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:3000/api/DataB/${collectionName}/${speciality}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["message"]["listCollections"];
      return data
          .map<ListingModel>((json) => ListingModel.fromMap(json))
          .toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }

  Future<bool> deletetry(String id) async {
    String collectionName = "doctors";
    final http.Response response = await http.delete(
        Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}/${id}'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
