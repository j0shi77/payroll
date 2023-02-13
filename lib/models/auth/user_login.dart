// To parse this JSON data, do
//
//     final userlogin = userloginFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Userlogin userloginFromJson(String str) => Userlogin.fromJson(json.decode(str));

String userloginToJson(Userlogin data) => json.encode(data.toJson());

class Userlogin {
  Userlogin({
     this.user,
     this.token,
     this.errorMessage
  });

  User? user;
  String? token;
  String? errorMessage;

  factory Userlogin.fromJson(Map<String, dynamic> json) =>
    Userlogin(
        user: json["user"] != null? User.fromJson(json["user"]) : null,
        token: json["token"],
        errorMessage: json["error_message"]
    );


  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
        "error_message" : errorMessage
      };
}

class User {
  User({
    required this.id,
    required this.branchId,
    required this.name,
    required this.noTelp,
    required this.email,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.avatar,
    required this.signature,
    required this.lang,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic branchId;
  String name;
  dynamic noTelp;
  String email;
  dynamic emailVerifiedAt;
  dynamic roleId;
  dynamic avatar;
  dynamic signature;
  dynamic lang;
  int isActive;
  dynamic createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        branchId: json["branch_id"],
        name: json["name"],
        noTelp: json["no_telp"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        avatar: json["avatar"],
        signature: json["signature"],
        lang: json["lang"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "name": name,
        "no_telp": noTelp,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "avatar": avatar,
        "signature": signature,
        "lang": lang,
        "is_active": isActive,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
