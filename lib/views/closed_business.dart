import 'package:flutter/material.dart';

class ClosedBussiness extends StatelessWidget {
  const ClosedBussiness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'BUSINESS CLOSED',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
