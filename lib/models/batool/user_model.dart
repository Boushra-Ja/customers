
import 'dart:convert';

UserModel userFromJson(String str) => UserModel.toObject(json.decode(str));

class UserModel {
  User user;
  String token;

  UserModel({required this.user, required this.token});

  factory UserModel.toObject(Map<String, dynamic> json) =>
      UserModel(
        user: User.toObject(
            json['user']),
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
    "user" : user.toJson(),
    "token" : token,
  };
}

class User {
  int id;
  String name;
  String email;
  var image;

  User({required this.id, required this.name, required this.email , required this.image});

  factory User.toObject(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], email: json['email'] , image: json['image']);

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "email" : email,
    "image" : image
  };

}
















