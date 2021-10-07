import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xchange/services/auth_service.dart';
import 'package:xchange/views/confirm_otp.dart';

import 'package:provider/provider.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String verificationId = '';
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumber = TextEditingController();
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: phoneNumber.text,
                verificationCompleted: (PhoneAuthCredential credential) async {
                  setState(() {
                    isLoading = false;
                  });
                  
                },
                verificationFailed: (FirebaseAuthException e) async {
                  // _scaffoldKey.currentState!.showSnackBar(snackbar);
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'error: ${e.message}',
                    style: Theme.of(context).textTheme.bodyText1,
                  )));
                },
                codeSent: (String verificationId, int? resendToken) async {
                  setState(() {
                    isLoading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (String verificationId) async {},
              );
            }),
        appBar: AppBar(
          title: Text(
            'Employee Login',
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: phoneNumber,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              focusColor: Theme.of(context).primaryColor,
                              border: const OutlineInputBorder(),
                              label: const Text('Phone Number'),
                              icon: const Icon(Icons.phone)),
                        ),
                      )
                    ],
                  )
                : ConfirmOTP(phoneNumber: phoneNumber.text));
  }
}
