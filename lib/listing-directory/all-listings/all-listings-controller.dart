import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../single-listing/single-listing-model.dart';

class AllListingsMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<ListingModel>> getAllListings() async {
    String collectionName = "doctors";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    if (response.statusCode == 200) {
      final listings = jsonDecode(response.body);
      final allListings = listings["message"]["listCollections"];
      return allListings
          .map<ListingModel>((json) => ListingModel.fromMap(json))
          .toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }

  Future<List<ListingModel>> getAllListingsWithCategories(
      String speciality) async {
    String collectionName = "doctors";
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:3000/api/DataB/${collectionName}/${speciality}'));
    if (response.statusCode == 200) {
      final listings = jsonDecode(response.body);
      final allListings = listings["message"]["listCollections"];
      return allListings
          .map<ListingModel>((json) => ListingModel.fromMap(json))
          .toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }


}
