import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fare_rate_mm/models/tranasction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logic/dropdown_provider.dart';
import '../logic/focus_change_notifire.dart';
import '../logic/loading_change_provider.dart';
import '../logic/riverpod_providers.dart';
import '../logic/text_input_change_notifire.dart';

String userId = FirebaseAuth.instance.currentUser!.phoneNumber!;
final DocumentReference currentStockDocumentRef =
    FirebaseFirestore.instance.collection('currentStock').doc(userId);
void addTransactionToFirebase({
  required String currency,
  required double initialVal,
  required double finalVal,
  required double rate,
  required bool isBuying,
  required BuildContext context,
}) async {
  await FirebaseFirestore.instance
      .collection('transactions')
      .add(
        TransactionModel(
          userNumber: userId,
          currency: currency,
          // ? chnges done here
          finalValue: finalVal,
          initialValue: initialVal,
          isBuying: isBuying,
          rate: rate,
          transactionTime: FieldValue.serverTimestamp(),
        ).toMap(),
      )
      .then((value) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     duration: Duration(milliseconds: 600),
    //     backgroundColor: Colors.white,
    //     content: Text(
    //       'Successful',
    //       style: TextStyle(color: Colors.green),
    //     ),
    //   ),
    // );
  }).catchError((e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.symmetric(vertical: 10),
        duration: Duration(milliseconds: 2000),
        backgroundColor: Colors.white,
        content: Text(
          'Something went wrong, please try again',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  });
}

class PostToFirebase {
  final Ref ref;

  PostToFirebase(this.ref);

  

  void updateCurrentStock({
  required BuildContext context,
}) {
    final _inputTextChangeNotifire2 = ref.watch(inputTextChangeNotifire);
    final _dropdownProvider = ref.watch(dropDownChangeNotifire);
    final _currentStockStreamProvider = ref.watch(currentStockStreamProvider);
    double roundDouble(double value) {
  num mod = pow(10.0, 2);
  return ((value * mod).round().toDouble() / mod);
}

  FirebaseFirestore.instance
      .collection('currentStock')
      .doc(userId)
      .set({
        _dropdownProvider.dropDownValue == 'UG' ? 'ush' : 'usd':  _dropdownProvider.dropDownValue == 'UG'
                  ? _currentStockStreamProvider.value!.ush +
                      roundDouble(_inputTextChangeNotifire2.calculatedText)
                  : _currentStockStreamProvider.value!.usd +
                      roundDouble(_inputTextChangeNotifire2.calculatedText),
        'ksh': _currentStockStreamProvider.value!.ksh +
                  double.parse(_inputTextChangeNotifire2.inputText!),
      }, SetOptions(merge: true))
      .then((value) => {})
      .catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: EdgeInsets.symmetric(vertical: 10),
            duration: Duration(milliseconds: 2000),
            backgroundColor: Colors.white,
            content: Text(
              'Something went wrong, please try again',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      });
}

}

void updateCurrentStock({
  required double from,
  required double to,
  required String fromName,
  required String toName,
  required BuildContext context,
}) {
  FirebaseFirestore.instance
      .collection('currentStock')
      .doc(userId)
      .set({
        fromName: from,
        toName: to,
      }, SetOptions(merge: true))
      .then((value) => {})
      .catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            margin: EdgeInsets.symmetric(vertical: 10),
            duration: Duration(milliseconds: 2000),
            backgroundColor: Colors.white,
            content: Text(
              'Something went wrong, please try again',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      });
}

final postToFirebaseProvider = Provider<PostToFirebase>((ref) {
  return PostToFirebase(ref);
});