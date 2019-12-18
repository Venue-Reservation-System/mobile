import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class User {

  String name = 'name';
   String username = '';
  String email = '';
  String password = '';

  User({
    this.name,this.username,this.email,this.password
  });

//   Map toMap() {
//     var map = new Map<String, String>();
//     map["username"] = username;
//     map["email"] = email;
//     map["password"] = password;
//     map["name"] = name;
//
//
//     return map;
//   }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);







}


User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'name': instance.name,
  'username': instance.username,
  'password': instance.password,
  'email': instance.email
};