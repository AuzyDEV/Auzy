import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../../../listing-directory/add-listing-category/add-listing-category-model.dart';

class SingleListingCategoryMan {

  Future<ListingCtegoryModel> getListingCategoryDetails(String id) async {
    String collectionName = "listingCategory";
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}/${id}'));
    if (response.statusCode == 200) {
      final listingDetails = jsonDecode(response.body);
      return ListingCtegoryModel.fromMaq(listingDetails);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> deleteListingCategory(String id) async {
    String collectionName = "listingCategory";
    final http.Response response = await http.delete(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}/${id}'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
