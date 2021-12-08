import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fare_rate_mm/models/rate.dart';
import 'package:fare_rate_mm/models/stock_model.dart';
import 'package:fare_rate_mm/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Store {
  DocumentReference userDocument = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber);
  CollectionReference buyingRateCollection =
      FirebaseFirestore.instance.collection('buyingRate');
  final DocumentReference buyingRatelast = FirebaseFirestore.instance
      .collection('buyingRate')
      .doc('6PKMVxXXAvwAxhdcDZsr');
  final DocumentReference sellingRatelast = FirebaseFirestore.instance
      .collection('sellingRate')
      .doc('dLLxgZBJkAayNKDqLOMX');
  final DocumentReference stockDocumentRef = FirebaseFirestore.instance
      .collection('assignedStock')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber);
  CollectionReference transationCollection =
      FirebaseFirestore.instance.collection('transaction');


  Stream<UserModel> get currentUser {
    return userDocument.snapshots().map((e) => UserModel(
          name: e.get('name'),
          phoneNumber: e.get('number'),
          isActivated: e.get('isActivated'),
          createdOn: e.get('time'),
        ));
  }

  Stream<Rate> get currentBuyingRate {
    return buyingRatelast.snapshots().map((e) => Rate(
          ksh: e.get('Ksh'),
          ush: e.get('Ush'),
          time: e.get('createdOn'),
          usd: e.get('Usd'),
        ));
  }

  Stream<Rate> get currentSellingRate {
    return sellingRatelast.snapshots().map((e) => Rate(
          ksh: e.get('Ksh'),
          ush: e.get('Ush'),
          time: e.get('createdOn'),
          usd: e.get('Usd'),
        ));
  }

  

  Stream<StockModel> get currentStock {
    return stockDocumentRef.snapshots().map((e) => StockModel(
          ksh: e.get('ksh'),
          createdOn: e.get('createdOn'),
          usd: e.get('usd'),
          ush: e.get('ush'),
        ));
  }
}
