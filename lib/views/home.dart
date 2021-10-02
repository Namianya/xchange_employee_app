import 'package:flutter/material.dart';
import 'package:my_keyboard/my_keyboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = '';
  String dropdownValue = "Ksh";

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
            leftIcon: const Icon(
              Icons.done,
              color: Colors.white,
              size: 30,
            ),
            rightIcon: const Icon(
              Icons.backspace,
              color: Colors.white,
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

/// This is the stateful widget that the main application instantiates.
class _CurrencyDropDown extends StatefulWidget {
  const _CurrencyDropDown({Key? key}) : super(key: key);

  @override
  State<_CurrencyDropDown> createState() => _CurrencyDropDownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _CurrencyDropDownState extends State<_CurrencyDropDown> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
