import 'dart:html';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:new_mee/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:dart_ipify/dart_ipify.dart';

class UserMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<User> Userslist;

  Future<String> signupUser(String email, String password, String displayName,
      String photoURL) async {
    final ipv4 = await Ipify.ipv4();
    final http.Response response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/ipadress'));
    print(response.body);
    final data1 = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final response1 = await http.post(
        Uri.parse('http://127.0.0.1:3000/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'displayName': displayName,
          'photoURL': photoURL,
          'ipadress': ipv4,
        }),
      );
      final data = jsonDecode(response1.body);
      return data['message'];
    }
  }

  Future<String> signinUser(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final data = jsonDecode(response.body);
    //print(data);
    return data['message'];
  }

  Future<String> resetpasswordUser(
    String email,
  ) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/resetemail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    final data = jsonDecode(response.body);
    return data['message'];
  }

  Future<String> SigninWithFacebook() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/logingoogle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data['message']);
      return data['message'];
    } else {
      return data['message'];
    }
  }

  Future<List> GetAllUsers() async {
    // ignore: deprecated_member_use
    Userslist = new List<User>();
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/get'));
    if (response.statusCode == 200) {
      // List<dynamic> body = jsonDecode(response.body);
      List body = jsonDecode(response.body);
      print(body);
      for (int i = 0; i < body.length; i++) {
        Userslist.add(new User.fromMappp(body[i]));
      }
    } else {
      throw Exception("Failed to upload product list");
    }
  }

  Future<bool> deleteUser(String id) async {
    final http.Response response = await http
        .delete(Uri.parse('http://127.0.0.1:3000/api/userinfo/${id}'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAllUsers() async {
    final http.Response response = await http
        .delete(Uri.parse('http://127.0.0.1:3000/api/deleteallusers'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> GetUser(String id) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:3000/api/userinfoswithipadress/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print(data[0]["ipadress"]);
      return User.fromMapp(data[0]);
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<String> GetUserIPAdress(String id) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:3000/api/userinfoswithipadress/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[0]["ipadress"];
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> LogoutUser() async {
    final http.Response response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/logout'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> GetCurrentUser() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String uid = data[0]['uid'];
      //return User.fromMapp(data[0]);
      final response1 = await http
          .get(Uri.parse('http://127.0.0.1:3000/api/userinfos/${uid}'));
      if (response1.statusCode == 200) {
        final data1 = jsonDecode(response1.body);
        return User.fromMapp(data1[0]);
      } else {
        throw Exception("Failed to get infos");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<String> GetIDCurrentUser() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String uid = data[0]['uid'];
      //return User.fromMapp(data[0]);
      return uid;
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> DeleteCurrentUser() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String uid = data[0]['uid'];
      print(data[0]['uid']);
      //User.fromMapp(data[0]);
      final http.Response response1 = await http
          .delete(Uri.parse('http://127.0.0.1:3000/api/userinfo/${uid}'));

      if (response1.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> UpdateprofilUser(
      String id, String email, String displayName, String photoURL) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/userinfo/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'displayName': displayName,
        'photoURL': photoURL,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ChangePassword(String password) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:3000/api/userpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      var GoogleAuthProvider;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithGoogle(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    } catch (e) {
      print(e);
    }
  }

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await FirebaseAuth.instance.signOut();
    // Sign out with google
    print('signout');
  }

  Future<FirebaseUser> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      print(loginResult.message);
      // Create a credential from the access token
      //final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

      return FirebaseAuth.instance
          .signInWithFacebook(accessToken: loginResult.accessToken.token);
    } catch (e) {
      print(e);
    }
  }

  Future<String> pushNotification() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/api/sendnotif'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = jsonDecode(response.body);
    String res = data['message'];
    print(res);
    return res;
  }

  /*Future<FirebaseUser> signInWithFacebookk() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      print(result.message);
      switch (result.status) {
        case LoginStatus.success:
          var FacebookAuthProvider;
          final facebookCredential =
              FacebookAuthProvider.credential(result.accessToken.token);
          final userCredential = await FirebaseAuth.instance
              .signInWithFacebook(accessToken: result.accessToken.token);
          return userCredential;

        default:
          return null;
      }
    } catch (e) {
      print(e);
    }
  }*/

  Future<String> facebookSignin() async {
    try {
      final _instance = FacebookAuth.instance;
      final result = await _instance.login(permissions: ['email']);
      print(result.message);
      if (result.status == LoginStatus.success) {
        //  final OAuthCredential credential =
        //   FacebookAuthProvider.credential(result.accessToken.token);
        final a = await _auth.signInWithFacebook(
            accessToken: result.accessToken.token);
        await _instance.getUserData().then((userData) async {
          //await _auth.currentUser.up(userData['email']);
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

  Future<List<User>> GetAllUsersForChats() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/get'));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return parsed.map<User>((json) => User.fromMapp(json)).toList();
    } else {
      throw Exception("Failed to get children's list");
    }
  }

  Future<bool> BlockUser(String id) async {
    final response = await http.put(
        Uri.parse('http://127.0.0.1:3000/api/blocuser/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> RestoreUser(String id) async {
    final response = await http.put(
        Uri.parse('http://127.0.0.1:3000/api/restoreuser/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> BlockCurrentUser() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String uid = data[0]['uid'];
      //return User.fromMapp(data[0]);
      final response1 = await http.put(
          Uri.parse('http://127.0.0.1:3000/api/blocuser/${uid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response1.statusCode == 200) {
        final data1 = jsonDecode(response1.body);
        print(data1);
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<int> CountNumberOfUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/getnumberofusers'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int nbr = data["count"];
      return nbr;
    } else {
      throw Exception("Failed to get children's list");
    }
  }

/*************************************************************************************************************************/
  /* Future<bool> updatepass(String id, String password) async {
    final response = await http.patch(
      Uri.parse('https://auzy.herokuapp.com/api/updatepasswordparent/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  

  Future<bool> signup(
      String firstName,
      String lastName,
      String email,
      String adress,
      String town,
      String phoneNumber,
      String birthDate,
      String gender,
      String role,
      String maritalStatus,
      String job,
      String kinship,
      String password) async {
    final response = await http.post(
      Uri.parse('https://auzy.herokuapp.com/api/addparent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'adress': adress,
        'town': town,
        'phoneNumber': phoneNumber,
        'birthDate': birthDate,
        'gender': gender,
        'role': role,
        'maritalStatus': maritalStatus,
        'job': job,
        'kinship': kinship,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<Parent> updateprofilParent(
      String id,
      String firstName,
      String lastName,
      String email,
      String adress,
      String town,
      String phoneNumber,
      String birthDate,
      String maritalStatus,
      String job) async {
    final response = await http.patch(
      Uri.parse('https://auzy.herokuapp.com/api/updateparent/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'adress': adress,
        'town': town,
        'phoneNumber': phoneNumber,
        'birthDate': birthDate,
        'maritalStatus': maritalStatus,
        'job': job
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return Parent.fromMapp(data[0]);
    } else {
      throw Exception('Failed to create child.');
    }
  }

  Future<bool> signinParent(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('https://auzy.herokuapp.com/api/loginparent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print(" amaalt login ");

      final data = jsonDecode(response.body);
      print(data);
      // shared pref
      print("tawaa shred pref");
      var prefs = await SharedPreferences.getInstance();
      prefs.setString("token", data['token']);
      prefs.setString("id", data['_id']);
      String value = prefs.getString("token");
      // String value1 = prefs.getString("id");
      //print(value1);
      //print(data['token']);
      return true;
    } else {
      print(" ma amaaltesh login ");
      return false;
    }
  }

  Future<String> forgetPassword(
    String email,
  ) async {
    final response = await http.post(
      Uri.parse('https://auzy.herokuapp.com/api/forgotPasswordP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      print(" baathet email c bon !");

      final data = jsonDecode(response.body);
      //print(data);
      //print(data['data'][0]['code']);
      String resetToken = data['data'][0]['resetToken'];

      var prefs = await SharedPreferences.getInstance();
      prefs.setString("code", data['data'][0]['code']);

      return resetToken;
    } else {
      print(" ma  baathetesh email ");
    }
  }

  Future<bool> sendpassword(
    String email,
  ) async {
    final response = await http.post(
      Uri.parse('https://auzy.herokuapp.com/api/sendpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      print(" baathet email c bon !");

      final data = jsonDecode(response.body);
      String resetToken = data['data'];

      return true;
    } else {
      print(" ma  baathetesh email ");
      return false;
    }
  }

  Future<bool> resetpassword(String token, String password) async {
    final response = await http.patch(
      Uri.parse('https://auzy.herokuapp.com/api/resetPasswordP/${token}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data);
      return true;
    } else {
      return false;
    }
  }*/
}
