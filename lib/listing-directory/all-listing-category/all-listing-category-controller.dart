import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../add-listing-category/add-listing-category-model.dart';

class CategoryListingCtegoryMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<ListingCtegoryModel>> getAllListingCtegories() async {
    String collectionName = "listingCategory";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["listCollections"];
      return data
          .map<ListingCtegoryModel>((json) => ListingCtegoryModel.fromMap(json))
          .toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }
}
