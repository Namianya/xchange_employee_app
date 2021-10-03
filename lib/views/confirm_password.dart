import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ConfirmNumber extends StatelessWidget {
  const ConfirmNumber({Key? key,required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final _codeController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Enter confirmation mumber',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          PinPut(
            fieldsCount: 5,
            controller: _codeController,
          )
        ],
      ),
    );
  }
}
