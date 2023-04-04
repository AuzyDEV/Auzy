import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../single-listing/single-listing-model.dart';

class DBDoctorMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> addNewDoctor(
      String firstName,
      String lastName,
      String speciality,
      String email,
      String phoneNumber,
      String Adress) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/addDB'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'speciality': speciality,
        'email': email,
        'Adress': Adress,
        'phoneNumber': phoneNumber,
        'collectionName': "doctors"
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      String doctorId = data["id"];
      return doctorId;
    } else {
      throw Exception("Failed to get infos");
    }
  }
}
