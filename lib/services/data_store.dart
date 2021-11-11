import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xchange/services/rate.dart';

class Store {
  // final Stream<QuerySnapshot> buyingRateStream = FirebaseFirestore.instance
  //     .collection('buyingRate')
  //     .orderBy(
  //       'createdOn',
  //       descending: true,
  //     )
  //     .snapshots();
  CollectionReference buyingRateCollection =
      FirebaseFirestore.instance.collection('buyingRate');
  final Stream<QuerySnapshot> buyingRatelast = FirebaseFirestore.instance
      .collection('buyingRate')
      .orderBy(
        'createdOn',
        descending: true,
      ).limit(1)
      .snapshots();
 



  List<Rate> _buyingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => Rate(
              ksh: e.get('Ksh'),
              ush: e.get('Ush'),
              usd: e.get('Usd'), time: 'createdOn',
            ))
        .toList();
  }

  Stream<List<Rate>> get rate {
    return buyingRateCollection.snapshots().map(_buyingListFromSnapshot);
  }

  
}
