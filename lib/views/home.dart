import 'package:flutter/material.dart';
import 'package:my_keyboard/my_keyboard.dart';
import 'package:xchange/views/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = '';
  String buyingDropdownValue = "Ksh";
  String sellingDropdownValue = "Ush";
  int rate = 1;
  double result = 0;
  bool buyOrSell = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Xchange', style: Theme.of(context).textTheme.headline6),
        // centerTitle: true,
        leading: const Icon(Icons.menu),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            child: const Hero(
              tag: 'avatar',
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80'),
                radius: 20,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value: buyingDropdownValue,
                icon: const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.green,
                ),
                iconSize: 24,
                elevation: 16,
                style: Theme.of(context).textTheme.headline6,
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    buyingDropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Ksh',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: sellingDropdownValue,
                icon: const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.orange,
                ),
                iconSize: 24,
                elevation: 16,
                style: Theme.of(context).textTheme.headline6,
                underline: Container(
                  height: 2,
                  color: Colors.orange,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    sellingDropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Ksh',
                  'Ush',
                  'USD',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '1',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.green,
                    ),
              ),
              Text(
                '$rate',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.orange,
                    ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            icon: buyOrSell
                ? const Icon(Icons.arrow_forward)
                : const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                buyOrSell = !buyOrSell;
              });
            },
            label: Text(
              buyOrSell ? 'BUYING' : 'SELLING',
            ),
            style: ElevatedButton.styleFrom(
                primary: buyOrSell ? Colors.green : Colors.orange),
          ),
          Text(
            'RESULT',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            '${result != 0 ? result : '_ _'} $sellingDropdownValue',
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Colors.black),
          ),
          const Spacer(),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black),
          ),
          NumericKeyboard(
            onKeyboardTap: onKeyboardTap,
            leftButtonFn: () {
              setState(() {
                result = double.parse(text) * rate;
              });
            },
            rightButtonFn: () {
              setState(() {
                // text = text.substring(0, text.length - 1);
                text = '';
                result = 0;
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
