// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class TextKey extends StatelessWidget {
//   const TextKey({
//     Key? key,
//     required this.text,
//     this.onTextInput,
//     this.flex = 1,
//   }) : super(key: key);
//   final String text;
//   final ValueSetter<String>? onTextInput;
//   final int flex;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(1.0),
//         child: Material(
//           color: Colors.white,
//           child: InkWell(
//             onTap: () {
//               onTextInput?.call(text);
//             },
//             child: Container(
//               child: Center(child: Text(text)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BackspaceKey extends StatelessWidget {
//   const BackspaceKey({
//     Key? key,
//     this.onBackspace,
//     this.flex = 1,
//   }) : super(key: key);
//   final VoidCallback? onBackspace;
//   final int flex;
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: flex,
//       child: Padding(
//         padding: const EdgeInsets.all(1.0),
//         child: Material(
//           color: Colors.blue.shade300,
//           child: InkWell(
//             onTap: () {
//               onBackspace?.call();
//             },
//             child: Container(
//               child: Center(
//                 child: Icon(Icons.backspace),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// List keyboardButtons = [
//   '1',
//   '2',
//   '3',
//   '4',
//   '5',
//   '6',
//   '7',
//   '8',
//   '9',
//   '0',
//   '.',
//   '=',
//   'X'
// ];

// class AppKeyboard extends StatelessWidget {
//   const AppKeyboard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 3,
//       children: keyboardButtons.map((text) {
//         if (text == '=') {
//           return TextKey(
//             text: text,
//             onTextInput: (text) {
//               print(text);
//             },
//           );
//         } else if (text == 'X') {
//           return BackspaceKey(
//             onBackspace: () {
//               print('backspace');
//             },
//           );
//         } else {
//           return TextKey(
//             text: text,
//             onTextInput: (text) {
//               print(text);
//             },
//           );
//         }
//       }).toList(),
//     );
//   }
  
// }


// void _insertText({required String myText,required TextEditingController _controller}) {
//   final text = _controller.text;
//   final textSelection = _controller.selection;
//   final newText = text.replaceRange(
//     textSelection.start,
//     textSelection.end,
//     myText,
//   );
//   final myTextLength = myText.length;
//   _controller.text = newText;
//   _controller.selection = textSelection.copyWith(
//     baseOffset: textSelection.start + myTextLength,
//     extentOffset: textSelection.start + myTextLength,
//   );
// }