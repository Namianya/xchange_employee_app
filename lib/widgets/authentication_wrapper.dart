import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/network/connection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:fare_rate_mm/views/login.dart';
import 'package:fare_rate_mm/views/no_network.dart';
import 'package:fare_rate_mm/views/second_home.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(authChange);
    // var currentconnectionStatus = ref.watch(connectivityStatus);
    var network = ref.watch(networkAwareProvider);
    if (network == NetworkStatus.NotDetermined) {
      return NoNetwork();
    } else {
      print(network);
      return firebaseUser.when(
          data: (data) => data?.uid != null ? SecondHome() : LoginPage(),
          error: (e, s) => Center(
                child: Text('Login'),
              ),
          loading: () => const CircularProgressIndicator());
    }
  }
}
