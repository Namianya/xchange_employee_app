import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class StockModel {
  Timestamp createdOn;
  double ksh;
  double usd;
  double ush;
  StockModel({
    required this.createdOn,
    required this.ksh,
    required this.usd,
    required this.ush,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdOn': createdOn,
      'ksh': ksh.toDouble(),
      'usd': usd.toDouble(),
      'ush': ush.toDouble(),
    };
  }

  factory StockModel.fromSnapshot(DocumentSnapshot doc) {
    return StockModel(
      createdOn: doc['createdOn'] ?? Timestamp.now(),
      ksh: doc['ksh'].toDouble() ?? 0,
      usd: doc['usd'].toDouble() ?? 0,
      ush: doc['ush'].toDouble() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockModel.fromJson(String source) =>
      StockModel.fromSnapshot(json.decode(source));
}
