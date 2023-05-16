import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class EditSingleListingCategoryMan {
  Future<bool> editListingCategory(String id, String name) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/updateDB/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'collectionName': "listingCategory",
        'Name': name,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
