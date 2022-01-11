import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pin_put/pin_put.dart';

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
  TextEditingController firstName = TextEditingController();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  final _formKey = GlobalKey<FormState>();

  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  @override
  Widget build(BuildContext context) {
    print(number.dialCode);
    void signInWithPhoneAuthCredential(
        PhoneAuthCredential phoneAuthCredential) async {
      setState(() {
        isLoading = true;
      });
      try {
        final authCredential = await FirebaseAuth.instance.signInWithCredential(
          phoneAuthCredential,
        );
        if (authCredential.user != null) {}
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

            _formKey.currentState?.validate();
            var doc = await _userCollection
                .doc(number.dialCode! + phoneNumber.text)
                .get();
            if (doc.exists) {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Authenticating...')),
                );
                setState(() {
                  isLoading = true;
                });

                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: number.dialCode! + phoneNumber.text,
                  verificationCompleted:
                      (PhoneAuthCredential credential) async {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  verificationFailed: (FirebaseAuthException e) async {
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
                      currentState =
                          MobileVerificationState.SHOW_OTP_FORM_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (String verificationId) async {},
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('User not found Contact admin'),
                ),
              );
            }
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
              ? Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (phone) {
                            number = phone;
                          },
                          locale: 'en_KE',
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (number.dialCode == '+254' && value[0] == '0') {
                              return 'Omit the leading zero for Kenyan numbers';
                            }
                            if (value.length < 9) {
                              return 'Invalid phone number';
                            }

                            return null;
                          },
                          onInputValidated: (value) => print(value),
                          inputBorder: OutlineInputBorder(),
                          initialValue: number,
                          autoFocus: true,
                          hintText: 'Enter phone number',
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          textFieldController: phoneNumber,
                          formatInput: false,
                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                        ),
                      ),
                     
                    ],
                  ),
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

  void getPhoneNumber(String phoneNumber) async {
    setState(() {
      this.number = number;
    });
    print(number);
  }
}
