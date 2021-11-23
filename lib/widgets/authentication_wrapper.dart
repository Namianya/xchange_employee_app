import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:fare_rate_mm/views/home.dart';
import 'package:fare_rate_mm/views/login.dart';
import 'package:fare_rate_mm/views/no_network.dart';
import 'package:fare_rate_mm/views/second_home.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.Offline) {
      return const NoNetwork();
    } else {
      if (firebaseUser != null) {
        return const Home();
        // return SecondHome();
      }
      return const LoginPage();
    }
  }
}
