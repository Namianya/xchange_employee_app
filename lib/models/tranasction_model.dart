import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? userNumber;
  double rate;
  bool isBuying;
  String currency;
  double initialValue;
  double finalValue;
  Timestamp transactionTime;

  TransactionModel({
    this.userNumber,
    required this.rate,
    required this.isBuying,
    required this.currency,
    required this.initialValue,
    required this.finalValue,
    required this.transactionTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'userNumber': userNumber,
      'rate': rate,
      'isBuying': isBuying,
      'currency': currency,
      'initialValue': initialValue,
      'finalValue': finalValue,
      'transactionTime': transactionTime,
    };
  }

  factory TransactionModel.fromMap(DocumentSnapshot map) {
    return TransactionModel(
      userNumber:
          map['userNumber'] != null ? map['userNumber'] : 'Some random number',
      rate: map['rate'],
      isBuying: map['isBuying'],
      currency: map['currency'],
      initialValue: map['initialValue'],
      finalValue: map['finalValue'],
      transactionTime: map['transactionTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));
}
