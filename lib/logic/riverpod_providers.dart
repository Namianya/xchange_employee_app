import 'package:fare_rate_mm/models/stock_model.dart';
import 'package:fare_rate_mm/network/connectivity_service.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:fare_rate_mm/services/auth_service.dart';
import 'package:fare_rate_mm/services/data_store.dart';
import 'package:fare_rate_mm/models/rate.dart';
import 'package:fare_rate_mm/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authService =
    Provider<AuthService>((ref) => AuthService(FirebaseAuth.instance));

final authChange = StreamProvider<User?>((authService) {
  return AuthService(FirebaseAuth.instance).authStateChanges;
});

final connectivityStatus = StreamProvider<ConnectivityStatus>((ref) {
  return ConnectivityService().connectionStatusController.stream;
});

// Change notifires providers

class IsBuyingChangeNotifier extends ChangeNotifier {
  bool isBuying = true;

  void setIsBuying() {
    isBuying = !isBuying;
    notifyListeners();
  }
}

final isBuyingChangeNotifier = ChangeNotifierProvider<IsBuyingChangeNotifier>(
  (ref) => IsBuyingChangeNotifier(),
);

// ? State notifiers
class IsBuyingStateProvider extends StateNotifier<bool> {
  IsBuyingStateProvider() : super(false);

  void changeBuyingState() {
    state = !state;
  }
}

final isBuyingState = StateNotifierProvider((ref) => IsBuyingStateProvider());

// Data store riverpods

final currentUserData = StreamProvider<UserModel>((ref) => Store().currentUser);
final buyingRateData = StreamProvider<Rate>((ref) => Store().currentBuyingRate);
final sellingRateData =
    StreamProvider<Rate>((ref) => Store().currentSellingRate);

final stockStream= StreamProvider<StockModel>((ref) => Store().currentStock);
