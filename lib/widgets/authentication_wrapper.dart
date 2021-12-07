import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fare_rate_mm/network/connectivity_service.dart';
import 'package:fare_rate_mm/services/riverpod_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:fare_rate_mm/views/home.dart';
import 'package:fare_rate_mm/views/login.dart';
import 'package:fare_rate_mm/views/no_network.dart';
import 'package:fare_rate_mm/views/second_home.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(authChange);
    var currentconnectionStatus = ref.watch(connectivityStatus);
    if (currentconnectionStatus.value == null) {
      print('Connection Status: Offline');
      return const NoNetwork();
    } else {
      if (firebaseUser != null) {
        print(currentconnectionStatus.value);
        return const Home();
        // return SecondHome();
      }
      return const LoginPage();
    }
  }
}
