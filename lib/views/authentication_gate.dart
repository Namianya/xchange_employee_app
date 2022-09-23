import 'package:fare_rate_mm/views/second_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
// import 'package:xchange_admin/views/home.dart';

class AuthenticationGate extends StatelessWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is not signed in - show a sign-in screen
          if (!snapshot.hasData) {
            return SignInScreen(
              auth: FirebaseAuth.instance,
              providerConfigs: [
                PhoneProviderConfiguration(),
              ],
            );
          }

          return const SecondHome();
        },
      );
}
