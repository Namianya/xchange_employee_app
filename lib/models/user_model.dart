import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String phoneNumber;
  final String userName;
  final bool isActivated;
  bool? isDayShift = true;
  bool? kenyaShop = true;
  final Timestamp? createdOn;

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
      'isDayShift': isDayShift,
      'kenyaShop': kenyaShop,
      'createdOn': createdOn,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    return UserModel(
      
      userName: doc['userName'] ?? '',
      isActivated: doc['isActivated'] ?? false,
      phoneNumber: doc['number'] ?? '',
      isDayShift: doc['isDayShift'],
      kenyaShop: doc['kenyaShop'],
      createdOn: doc['createdOn'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromSnapshot(json.decode(source));
}
