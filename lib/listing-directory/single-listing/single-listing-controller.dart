import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../single-listing/single-listing-model.dart';

class SingleListingMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ListingModel> getListingDetails(String id) async {
    String collectionName = "doctors";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}/${id}'));

    if (response.statusCode == 200) {
      final listingDetails = jsonDecode(response.body);
      return ListingModel.fromMaq(listingDetails);
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
