import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../single-listing/single-listing-model.dart';

class SingleListingMan {

  Future<ListingModel> getListingDetails(String id) async {
    String collectionName = "doctors";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}/${id}'));

    if (response.statusCode == 200) {
      final listingDetails = jsonDecode(response.body);
      print(listingDetails["listings"]);
      return ListingModel.fromMaq(listingDetails);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> deleteListing(String id) async {
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
