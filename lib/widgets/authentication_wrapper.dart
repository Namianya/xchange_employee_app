import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/network/connection.dart';
import 'package:fare_rate_mm/views/authentication_gate.dart';
import 'package:fare_rate_mm/views/closed_business.dart';
import 'package:fare_rate_mm/views/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:fare_rate_mm/views/no_network.dart';
import 'package:fare_rate_mm/views/second_home.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firebaseUser = ref.watch(authChange);
    final _settingsStream = ref.watch(settingsStreamProvider);
    final _currentUser = ref.watch(currentUserData);

    final network = ref.watch(networkAwareProvider);
    if (network == NetworkStatus.NotDetermined) {
      return NoNetwork();
    } else {
      print(network);
      return _firebaseUser.when(
        data: (data) => data?.uid != null
            ? _settingsStream.when(
                data: (data) => !data.closed
                    ? _currentUser.when(
                        data: (data) => data.isActivated
                            ? SecondHome()
                            : Scaffold(
                                body: Center(
                                  child: Text(
                                      'Not Enough permissions to access this app'),
                                ),
                              ),
                        loading: () => Scaffold(
                                body: Center(
                              child: CircularProgressIndicator(),
                            )),
                        error: (error, s) => Scaffold(
                              body: Center(
                                child: Text('$error'),
                              ),
                            ))
                    : ClosedBussiness(),
                loading: () => Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (e, s) =>
                    Scaffold(body: Center(child: Text('Please Restart your App'))),
              )
            // : AuthenticationGate(),
            : LoginPage(),
        error: (e, s) => Center(
          child: Text('Login'),
        ),
        loading: () => const CircularProgressIndicator(),
      );
    }
  }
}
