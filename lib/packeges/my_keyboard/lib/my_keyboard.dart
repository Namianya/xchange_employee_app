library my_keyboard;

import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;
  final Color? leftButtonColor;
  final Color? rightButtonColor;

  /// Display a custom right icon
  final Widget? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Widget? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  const NumericKeyboard(
      {Key? key,
      required this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly, this.leftButtonColor, this.rightButtonColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _calcButton('0'),
              InkWell(
                  splashColor: Colors.green[900],
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.leftButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.leftButtonColor ?? Colors.green,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: 100,
                      height: 50,
                      child: widget.leftIcon)),
              InkWell(
                  splashColor: Colors.red[900],
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.rightButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.rightButtonColor ?? Colors.red[400],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 50,
                      height: 50,
                      child: widget.rightIcon))
            ],
          ),
        ],
      ),
    );
  }

  // !original code

//   Widget _calcButton(String value) {
//     return InkWell(
//         borderRadius: BorderRadius.circular(45),
//         onTap: () {
//           widget.onKeyboardTap(value);
//         },
//         child: Container(
//           alignment: Alignment.center,
//           width: 50,
//           height: 50,
//           child: Text(
//             value,
//             style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: widget.textColor),
//           ),
//         ));
//   }
// }

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
      child:
          Text(value, style: Theme.of(context).textTheme.headline5?.copyWith()),
    );
  }
}
