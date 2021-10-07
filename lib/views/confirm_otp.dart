import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ConfirmOTP extends StatelessWidget {
  const ConfirmOTP(
      {Key? key, required this.phoneNumber, required this.verificationId})
      : super(key: key);
  final String verificationId;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    // final _codeController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter confirmation OTP for $phoneNumber',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          animatingBorders(verificationId: verificationId),
        ],
      ),
    );
  }
}

Widget animatingBorders({required String verificationId }) {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(color: Colors.deepPurpleAccent),
    borderRadius: BorderRadius.circular(15.0),
  );
  return PinPut(
    fieldsCount: 5,
    eachFieldHeight: 40.0,
    withCursor: true,
    // onSubmit: (String pin) => _showSnackBar(pin),
    onSubmit: (String pin) async {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _pinPutController.text,
      );
      // signInWithPhone(phoneAuthCredential);
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
  );
}


