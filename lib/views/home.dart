import 'package:flutter/material.dart';
import 'package:my_keyboard/my_keyboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Xchange', style: Theme.of(context).textTheme.headline6),
        // centerTitle: true,
        leading: const Icon(Icons.menu),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80'),
            radius: 20,
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      // body: GridView.count(
      //   crossAxisCount: 3,
      //   crossAxisSpacing: 20,
      //   mainAxisSpacing: 10,
      //   children: List.generate(9, (index) =>  DiallerButton(value: index,)),
      // ),
      body: Column(
        children: [
          const Spacer(),
          Text(text),
          NumericKeyboard(
            onKeyboardTap: onKeyboardTap,
            rightButtonFn: () {
              setState(() {
                // text = text.substring(0, text.length - 1);
                text = '';
              });
            },
            rightIcon: const Icon(
              Icons.backspace,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }
}
