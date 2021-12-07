import 'package:fare_rate_mm/network/connectivity_service.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:fare_rate_mm/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

  
final authService = Provider<AuthService>(
  (ref)=>AuthService(FirebaseAuth.instance)
  
);

final authChange = StreamProvider<User?>((authService) {
  return AuthService(FirebaseAuth.instance).authStateChanges;
});

final connectivityStatus = StreamProvider<ConnectivityStatus>((ref) {
  return ConnectivityService().connectionStatusController.stream;
});

