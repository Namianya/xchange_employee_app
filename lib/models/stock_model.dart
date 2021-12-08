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
      'ksh': ksh,
      'usd': usd,
      'ush': ush,
    };
  }

  factory StockModel.fromMap(DocumentSnapshot doc) {
    return StockModel(
      createdOn: doc['createdOn'] as Timestamp,
      ksh: doc['ksh'],
      usd: doc['usd'],
      ush: doc['ush'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockModel.fromJson(String source) =>
      StockModel.fromMap(json.decode(source));
}
