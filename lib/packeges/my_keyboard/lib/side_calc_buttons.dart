import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class SIdeCalcButton extends StatefulWidget {
  const SIdeCalcButton({ Key? key,required this.onKeyboardTap }) : super(key: key);
  final KeyboardTapCallback onKeyboardTap;

  @override
  _SIdeCalcButtonState createState() => _SIdeCalcButtonState();
}

class _SIdeCalcButtonState extends State<SIdeCalcButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }



  Widget _calcButton(String value) {
    return TextButton(
      onPressed: () {
        widget.onKeyboardTap(value);
      },
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
