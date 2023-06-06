import 'dart:convert';

List<User> postFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromMap(x)));

class User {
  String id;
  String email;
  String password;
  String displayName;
  String photoURL, ipadress, role;
  bool disabled;
  
  User({this.id, this.email, this.password, this.displayName, this.photoURL, this.disabled, this.ipadress, this.role});

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: (json["uid"] ?? ''),
      email: (json["email"] ?? ''),
      password: (json["password"] ?? ''),
    );
  }
  factory User.fromMapp(Map<String, dynamic> json) {
    return User(
      id: (json["uid"] ?? ''),
      email: (json["email"] ?? ''),
      password: (json["password"] ?? ''),
      displayName: (json["displayName"] ?? ''),
      photoURL: (json["photoURL"] ?? ''),
      disabled: (json["disabled"] ?? ''),
    );
  }
  factory User.fromMapy(Map<String, dynamic> json) {
    return User(
      id: (json["uid"] ?? ''),
      email: (json["email"] ?? ''),
      password: (json["password"] ?? ''),
      displayName: (json["displayName"] ?? ''),
      photoURL: (json["photoURL"] ?? ''),
      ipadress: (json["ipadress"] ?? ''),
      role: (json["role"] ?? ''),
    );
  }
  factory User.fromMappp(Map<String, dynamic> json) {
    return User(
      id: (json["uid"] ?? ''),
      email: (json["email"] ?? ''),
      password: (json["password"] ?? ''),
      displayName: (json["displayName"] ?? ''),
      photoURL: (json["photoURL"] ?? ''),
      disabled: (json["disabled"] ?? ''),
    );
  }

  static User fromJson(Map<String, dynamic> json) => User(
      id: (json["uid"] ?? ''),
      email: (json["email"] ?? ''),
      password: (json["password"] ?? ''),
      displayName: (json["displayName"] ?? ''),
      photoURL: (json["photoURL"] ?? ''),
    );
  factory User.fromMapChat(Map<String, dynamic> json) {
    return User(
      id: (json["uid"] ?? ''),
      email: (json["email"] ?? ''),
      displayName: (json["displayName"] ?? ''),
      photoURL: (json["photoURL"] ?? ''),
    );
  }

  factory User.fromM(Map<String, dynamic> json) {
    return User(
      id: (json["uid"] ?? ''),
      email: (json["email"] ?? ''),
      displayName: (json["displayName"] ?? ''),
    );
  }
}
