import 'package:cloud_firestore/cloud_firestore.dart';

class Rate {
  final String ksh;
  final String ush;
  final String usd;
  final Timestamp time;

  Rate({
    required this.time,
    required this.ksh,
    required this.ush,
    required this.usd,
  });

  static Rate fromSnapshot(DocumentSnapshot snap) {
    Rate rate = Rate(
        time: snap['createdOn']??Timestamp.now(),
        ksh: snap['Ksh']??'0',
        ush: snap['Ush']??'0',
        usd: snap['Usd']??'0');
    return rate;
  }
}
