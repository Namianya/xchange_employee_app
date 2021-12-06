import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fare_rate_mm/services/rate.dart';
import 'package:fare_rate_mm/services/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Store {
  String? num = FirebaseAuth.instance.currentUser!.phoneNumber;
  DocumentReference userDocument = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber);
  CollectionReference buyingRateCollection =
      FirebaseFirestore.instance.collection('buyingRate');
  final Stream<QuerySnapshot> buyingRatelast = FirebaseFirestore.instance
      .collection('buyingRate')
      .orderBy(
        'createdOn',
        descending: true,
      )
      .limit(1)
      .snapshots();

  List<Rate> _buyingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => Rate(
              ksh: e.get('Ksh'),
              ush: e.get('Ush'),
              usd: e.get('Usd'),
              time: 'createdOn',
            ))
        .toList();
  }

  Stream<List<Rate>> get rate {
    return buyingRateCollection.snapshots().map(_buyingListFromSnapshot);
  }

  Stream<UserModel> get currentUser {
    return userDocument.snapshots().map((e) => UserModel(
          name: e.get('name'),
          phoneNumber: e.get('number'),
          isActivated: e.get('isActivated'),
          createdOn: e.get('createdOn'),  
        ));
  }
}
