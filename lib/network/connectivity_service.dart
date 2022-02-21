import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityService extends StateNotifier<ConnectivityStatus> {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityService() : super(ConnectivityStatus.LoadingConnection) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(getStatusFromResult(result));
    });
  }
  
  ConnectivityStatus getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
        
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:

        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}



final connectivityStreamProvider = StreamProvider((ref) async* {
  yield* ConnectivityService().connectionStatusController.stream;
});