import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:xchange/views/home.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(color: Colors.deepPurpleAccent),
    borderRadius: BorderRadius.circular(15.0),
  );
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signInWithPhoneAuthCredential(
        PhoneAuthCredential phoneAuthCredential) async {
      setState(() {
        isLoading = true;
      });
      try {
        final authCredential = await FirebaseAuth.instance.signInWithCredential(
          phoneAuthCredential,
        );
        // setState(() {
        //   isLoading = false;
        // });
        if (authCredential.user != null) {
          FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
              .set({
            'number': FirebaseAuth.instance.currentUser!.phoneNumber,
            'time': FieldValue.serverTimestamp()
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${e.message}'),
          ),
        );
      }
    }

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
                // signInWithPhoneAuthCredential(credential);
                // FirebaseFirestore.instance.collection('transactions').add({
                //   'number': FirebaseAuth.instance.currentUser!.phoneNumber,
                //   'time': FieldValue.serverTimestamp()
                // });
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: phoneNumber,
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            focusColor: Theme.of(context).primaryColor,
                            border: const OutlineInputBorder(),
                            label: const Text('Phone Number'),
                            icon: const Icon(Icons.phone)),
                      ),
                    ),
                    const Text('Start with country code eg +254 7******')
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter confirmation OTP for ${phoneNumber.text}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      PinPut(
                        fieldsCount: 6,
                        eachFieldHeight: 40.0,
                        withCursor: true,
                        // onSubmit: (String pin) => _showSnackBar(pin),
                        onSubmit: (String pin) async {
                          PhoneAuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: _pinPutController.text,
                          );
                          signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        selectedFieldDecoration: pinPutDecoration,
                        followingFieldDecoration: pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withOpacity(.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
