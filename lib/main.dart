
import 'package:fare_rate_mm/services/data_store.dart';
import 'package:fare_rate_mm/services/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/theme.dart';
import 'package:fare_rate_mm/network/connectivity_service.dart';
import 'package:fare_rate_mm/services/auth_service.dart';
import 'package:fare_rate_mm/widgets/authentication_wrapper.dart';

import 'network/connectivity_status.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
            initialData: null),
        StreamProvider<ConnectivityStatus>.value(
          initialData: ConnectivityStatus.Offline,
          value: ConnectivityService().connectionStatusController.stream,
        ),
        // StreamProvider(
        //   create: (context) => context.read<Store>().currentUser,
        //   initialData: null,
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: myTheme,
        home: const AuthenticationWrapper(),
      ),
    );
  }
}
