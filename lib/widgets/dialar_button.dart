import 'package:flutter/material.dart';

class DiallerButton extends StatelessWidget {
  const DiallerButton({Key? key, this.value}) : super(key: key);
  final int? value;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.grey[200],
        padding: const EdgeInsets.all(20),
      ),
      child: Text('$value',
          style: Theme.of(context).textTheme.headline5?.copyWith()),
    );
  }
}
