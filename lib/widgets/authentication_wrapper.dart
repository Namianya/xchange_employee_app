import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fare_rate_mm/network/connectivity_service.dart';
import 'package:fare_rate_mm/logic/riverpod_providers.dart';
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
    return currentconnectionStatus.when(
        data: (dat) => currentconnectionStatus.value == null
            ? const NoNetwork()
            : firebaseUser.when(
                data: (data) => data?.uid != null ? SecondHome() : LoginPage(),
                error: (e, s) => Center(
                      child: Text('Login'),
                    ),
                loading: () => const CircularProgressIndicator()),
        error: (e, s) => Center(
              child: Text('Login'),
            ),
        loading: () => const CircularProgressIndicator());
  }
}
