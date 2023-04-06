import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_mee/listing-directory/add-listing-category/add-listing-category-model.dart';
import '../single-listing/single-listing-model.dart';

class ListingCtegoryMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addNewListingCategory(
    String Name,
  ) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/addDB'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'Name': Name, 'collectionName': "listingCategory"}),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      String listingCategoryId = data["id"];
      return listingCategoryId;
    } else {
      throw Exception("Failed to get infos");
    }
  }

}
