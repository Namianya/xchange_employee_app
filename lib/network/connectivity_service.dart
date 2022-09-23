import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService extends StateNotifier<ConnectivityStatus> {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityService() : super(ConnectivityStatus.LoadingConnection) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(getStatusFromResult(result));
    });
  }

  ConnectivityStatus getStatusFromResult(ConnectivityResult result) {
    bool isDeviceConnected = true;
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      print('Connected');
      InternetConnectionChecker().hasConnection.then((value) {
        isDeviceConnected = value;
      });
      if (isDeviceConnected) {
        return result == ConnectivityResult.mobile
            ? ConnectivityStatus.Cellular
            : ConnectivityStatus.WiFi;
      }
      return ConnectivityStatus.Offline;
    } else {
      return ConnectivityStatus.Offline;
    }
  }
}

final connectivityStreamProvider = StreamProvider((ref) async* {
  yield* ConnectivityService().connectionStatusController.stream;
});
