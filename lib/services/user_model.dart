import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String phoneNumber;
  final String name;
  final bool isActivated;
  final Timestamp createdOn;

  UserModel({
    required this.phoneNumber,
    required this.name,
    required this.isActivated,
    required this.createdOn,
  });


  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'userName': name,
      'isActivated': isActivated,
      'createdOn':createdOn
    };
  }

  factory UserModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    return UserModel(
      phoneNumber: data['phoneNumber']??'123456789',
      name: data['userName']??'Username',
      isActivated: data['isActivated']??false,
      createdOn: data['createdOn']?? Timestamp.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
