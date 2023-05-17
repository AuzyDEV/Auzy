import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SigninMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signinUser(String email,String password) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:3000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final user = jsonDecode(response.body);
    return user['message'];
  }

  Future<String> SigninWithFacebook() async {
    final response = await http.post(Uri.parse('http://127.0.0.1:3000/api/logingoogle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final user = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return user['message'];
    } else {
      return user['message'];
    }
  }

  Future<bool> LogoutUser() async {
    final http.Response response = await http.get(Uri.parse('http://127.0.0.1:3000/api/logout'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;
      var GoogleAuthProvider;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithGoogle( accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    } catch (e) {
      print(e);
    }
  }

  Future<Null> signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
    print('signout');
  }

  Future<FirebaseUser> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      return FirebaseAuth.instance.signInWithFacebook(accessToken: loginResult.accessToken.token);
    } catch (e) {
      print(e);
    }
  }

  Future<String> facebookSignin() async {
    try {
      final _instance = FacebookAuth.instance;
      final result = await _instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final a = await _auth.signInWithFacebook(accessToken: result.accessToken.token);
        await _instance.getUserData().then((userData) async {
        });
      return null;
      } else if (result.status == LoginStatus.cancelled) {
        return 'Login cancelled';
      } else {
        return 'Error';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
