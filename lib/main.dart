
import 'package:fare_rate_mm/widgets/authentication_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/theme.dart';


Future<void> main() async {
  // ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fare Rate',
        theme: myTheme,
        home: const AuthenticationWrapper(),
      );
  }
}
