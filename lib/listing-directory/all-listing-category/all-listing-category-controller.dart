import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../add-listing-category/add-listing-category-model.dart';

class CategoryListingCtegoryMan {

  Future<List<ListingCtegoryModel>> getAllListingCtegories() async {
    String collectionName = "listingCategory";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final listingCategories = jsonDecode(response.body);
      final listCategory = listingCategories["message"]["listCollections"];
      return listCategory
          .map<ListingCtegoryModel>((json) => ListingCtegoryModel.fromMap(json))
          .toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }
}
