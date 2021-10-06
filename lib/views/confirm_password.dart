import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ConfirmNumber extends StatelessWidget {
  const ConfirmNumber({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    // final _codeController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter confirmation mumber',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            animatingBorders(),
            // PinPut(
            //   validator: (s) {
            //     if (s!.contains('1')) return null;
            //     return 'NOT VALID';
            //   },
            //   withCursor: true,
            //   autofocus: true,
            //   fieldsCount: 5,
            //   selectedFieldDecoration: BoxDecoration(
            //     color: Colors.indigo[200],
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   submittedFieldDecoration: BoxDecoration(
            //     color: Colors.indigo[500],
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   controller: _codeController,
            // )
          ],
        ),
      ),
    );
  }
}

Widget animatingBorders() {
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
