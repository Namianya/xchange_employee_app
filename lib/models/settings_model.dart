import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  final bool canRegister;
  final bool closed;

  SettingsModel(this.canRegister, this.closed);

  Map<String, dynamic> toMap() {
    return {
      'canRegister': canRegister,
      'closed': closed,
    };
  }

  factory SettingsModel.fromSnapshot(DocumentSnapshot map) {
    return SettingsModel(
      map['canRegister'] ?? false,
      map['closed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) => SettingsModel.fromSnapshot(json.decode(source));
}
