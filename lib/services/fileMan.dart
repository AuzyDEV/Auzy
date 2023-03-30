import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import '../models/File.dart';

class fileMan {
  static List<String> fileslist;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> deleteFilePostFromDownloadURL(String downloadURL) async {
    final http.Response response =
        await http.delete(Uri.parse('http://127.0.0.1:3000/api/filepost'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'downloadURL': downloadURL,
            }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future donwloadFile(String downloadURL) async {
    try {
      final WebImageDownloader _webImageDownloader = WebImageDownloader();

      await _webImageDownloader.downloadImageFromWeb(downloadURL);
    } on PlatformException catch (error) {
      print(error);
    }
  }

  Future<List<File>> fetchDownloadUrls() async {
    final response1 =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response1.statusCode == 200) {
      final data = jsonDecode(response1.body);
      String uid = data[0]['uid'];
      final response =
          await http.get(Uri.parse('http://127.0.0.1:3000/api/files/$uid'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return parsed.map<File>((json) => File.fromMap(json)).toList();
      } else {
        throw Exception("Failed to fetch download URLs");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
