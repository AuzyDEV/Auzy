import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:new_mee/models/File.dart';

class fileMan {
  static List<String> fileslist;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<String>> getAllFilesofSpecificUser() async {
    fileslist = new List<String>();
    final response = await http.get(
      Uri.parse('http://127.0.0.1:3000/api/files/123'),
    );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final data = parsed["files"];
      //print(parsed);
      for (int i = 0; i < data.length; i++) {
        fileslist.add(data[i]);
      }
      return fileslist;
      //print(fileslist);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Uint8List> _loadImage() async {
    try {
      final response = await http.get(Uri.parse(
          "https://st2.depositphotos.com/1061433/9739/i/600/depositphotos_97393282-stock-photo-portrait-of-a-beautiful-girl.jpg"));
      return response.bodyBytes;
    } catch (error) {
      print(error);
    }
  }

  Future<File> GetFileByName(String name) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/getfile/${name}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print(data[0]["ipadress"]);
      //print(data[0]);
      return File.fromMapp(data[0]);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> deleteFile(String fileName) async {
    final http.Response response = await http
        .delete(Uri.parse('http://127.0.0.1:3000/api/deletefile/${fileName}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFileFromDownloadURL(String downloadURL) async {
    final http.Response response =
        await http.delete(Uri.parse('http://127.0.0.1:3000/api/file'),
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

/*
  Future uploadFile( String title, int subjectid, int teacherid, String limitDate) async {
    var url = Uri.parse('http://localhost:8000/newHomework');
    var request = http.MultipartRequest('POST', url);
    var headers = {'Content-Type': 'text/plain; charset=UTF-8'};
    

    request.files.add(new http.MultipartFile(
        "text", file.readStream, file.size,
        filename: "tarea1"));


    request.headers.addAll(headers);
    request.fields['title'] = title;
    request.fields['limitDate'] = limitDate;
    request.fields['subjectid'] = subjectid.toString();
    request.fields['teacherid'] = teacherid.toString();
    request.fields['ext'] = '.txt';

    var res = await request.send();
    return res.stream.bytesToString().asStream().listen((event) {
      var parsedJson = json.decode(event);
      print(parsedJson);
    });
  
    
  





    /*var imageFile = html.File(file.path.codeUnits, file.path);
    final bytes = await file.readAsBytes();
    final fileInBase64 = base64Encode(bytes);
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/sendfilee'),
      headers: <String, String>{'Content-Type': 'text/plain; charset=UTF-8'},
      body: {'file': fileInBase64},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }*/

  }*/
  Future<bool> uploadFileeeeee(
      BuildContext context, String filename, io.File file) async {
    print(file);
    var stream = new http.ByteStream((file.openRead()));
    stream.cast();
    var length = await file.length();

    final uri = Uri.parse("http://127.0.0.1:3000/api/sendfilee");
    var request = new http.MultipartRequest("POST", uri);
    final multipartFile =
        http.MultipartFile('file', stream, length, filename: file.path);

// add file to multipart
    request.files.add(multipartFile);

// send
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
