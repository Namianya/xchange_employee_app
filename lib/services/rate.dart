import 'package:cloud_firestore/cloud_firestore.dart';

class Rate {
  final String ksh;
  final String ush;
  final String usd;
  final String time;

  Rate({
    required this.time,
    required this.ksh,
    required this.ush,
    required this.usd,
  });

  static Rate fromSnapshot(DocumentSnapshot snap) {
    Rate rate = Rate(
        time: snap['createdOn'],
        ksh: snap['Ksh'],
        ush: snap['Ush'],
        usd: snap['Usd']);
    return rate;
  }
}
