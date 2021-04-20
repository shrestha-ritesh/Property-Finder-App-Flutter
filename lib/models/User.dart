// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.success,
    this.data,
  });

  int success;
  List<User> data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        success: json["success"],
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.userId,
    this.name,
    this.email,
    this.contactNo,
    this.regDate,
  });

  int userId;
  String name;
  String email;
  String contactNo;
  DateTime regDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        contactNo: json["contact_no"],
        regDate: DateTime.parse(json["reg_date"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "contact_no": contactNo,
        "reg_date": regDate.toIso8601String(),
      };
}
