import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/theme.dart';
import 'package:xchange/services/auth_service.dart';
import 'package:xchange/widgets/authentication_wrapper.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: myTheme,
        home: const AuthenticationWrapper(),
      ),
    );
  }
}
