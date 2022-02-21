import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker extends ChangeNotifier {
  InternetConnectionStatus connectionStatus =
      InternetConnectionStatus.connected;

  // _connectionStatus settter
  void connectionStatuschange(InternetConnectionStatus value) {
    connectionStatus = value;
    notifyListeners();
  }

  StreamSubscription<InternetConnectionStatus> listener() =>
      InternetConnectionChecker().onStatusChange.listen(
        (InternetConnectionStatus status) {
          switch (status) {
            case InternetConnectionStatus.connected:
              // ignore: avoid_print
              connectionStatuschange(status);
              notifyListeners();

              print('Data connection is available.');
              break;
            case InternetConnectionStatus.disconnected:
              // ignore: avoid_print
              connectionStatuschange(status);
              notifyListeners();
              print('You are disconnected from the internet.');
              break;
          }
        },
      );
}

final internetConectionProvider =
    ChangeNotifierProvider<InternetChecker>((ref) {
  return InternetChecker();
});

final internetConectionProviderStream =
    StreamProvider<Stream<InternetConnectionStatus>>((ref) async* {
  yield InternetConnectionChecker().onStatusChange;
});
