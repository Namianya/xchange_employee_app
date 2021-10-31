import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:xchange/network/connectivity_status.dart';
import 'package:xchange/views/home.dart';
import 'package:xchange/views/login.dart';
import 'package:xchange/views/no_network.dart';

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
      }
      return const LoginPage();
    }
  }
}
