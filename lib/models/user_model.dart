import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String phoneNumber;
  final String userName;
  final bool isActivated;
  bool? isDayShift = true;
  bool? kenyaShop = true;
  final FieldValue? createdOn;

  UserModel({
    this.isDayShift,
    this.kenyaShop,
    required this.phoneNumber,
    required this.userName,
    required this.isActivated,
    required this.createdOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'userName': userName,
      'isActivated': isActivated,
      'createdOn': createdOn,
      'isDayShift': isDayShift,
      'kenyaShop': kenyaShop,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    return UserModel(
      phoneNumber: data['phoneNumber'] ?? '123456789',
      isDayShift: data['isDayShift'] ?? true,
      userName: data['userName'] ?? 'Username',
      isActivated: data['isActivated'] ?? false,
      kenyaShop: data['kenyaShop'] ?? true,
      createdOn: data['createdOn'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromSnapshot(json.decode(source));
}
