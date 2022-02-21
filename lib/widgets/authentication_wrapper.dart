import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/network/connection.dart';
import 'package:fare_rate_mm/network/connectivity_service.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:fare_rate_mm/network/new_connectivity.dart';
import 'package:fare_rate_mm/views/closed_business.dart';
import 'package:fare_rate_mm/views/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:fare_rate_mm/views/no_network.dart';
import 'package:fare_rate_mm/views/second_home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firebaseUser = ref.watch(authChange);
    final _settingsStream = ref.watch(settingsStreamProvider);
    final _currentUser = ref.watch(currentUserData);
    final _connectivityStreamProvider = ref.watch(connectivityStreamProvider);
    

    return _connectivityStreamProvider.when(
      data: (data) => data == ConnectivityStatus.WiFi ||
              data == ConnectivityStatus.Cellular
          ? _firebaseUser.when(
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
                      error: (e, s) => Scaffold(
                          body: Center(child: Text('Please Restart your App'))),
                    )
                  // : AuthenticationGate(),
                  : LoginPage(),
              error: (e, s) => Center(
                child: Text('Login'),
              ),
              loading: () => const CircularProgressIndicator(),
            )
          : NoNetwork(),
      loading: () => Scaffold(
        body: const Center(
          child: Text('Loading ...'),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: const Center(
          child: Text('Loading ...'),
        ),
      ),
    );

    // if (_connectivityStreamProvider.connectionStatus ==
    //     InternetConnectionStatus.disconnected) {
    //   return NoNetwork();
    // } else {
    //   print(_internetConectionProvider.connectionStatus);
    //   return _firebaseUser.when(
    //     data: (data) => data?.uid != null
    //         ? _settingsStream.when(
    //             data: (data) => !data.closed
    //                 ? _currentUser.when(
    //                     data: (data) => data.isActivated
    //                         ? SecondHome()
    //                         : Scaffold(
    //                             body: Center(
    //                               child: Text(
    //                                   'Not Enough permissions to access this app'),
    //                             ),
    //                           ),
    //                     loading: () => Scaffold(
    //                             body: Center(
    //                           child: CircularProgressIndicator(),
    //                         )),
    //                     error: (error, s) => Scaffold(
    //                           body: Center(
    //                             child: Text('$error'),
    //                           ),
    //                         ))
    //                 : ClosedBussiness(),
    //             loading: () => Scaffold(
    //               body: Center(
    //                 child: CircularProgressIndicator(),
    //               ),
    //             ),
    //             error: (e, s) => Scaffold(
    //                 body: Center(child: Text('Please Restart your App'))),
    //           )
    //         // : AuthenticationGate(),
    //         : LoginPage(),
    //     error: (e, s) => Center(
    //       child: Text('Login'),
    //     ),
    //     loading: () => const CircularProgressIndicator(),
    //   );
    // }
  }
}
