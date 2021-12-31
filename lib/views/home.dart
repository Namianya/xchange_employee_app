import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_keyboard/my_keyboard.dart';
import 'package:fare_rate_mm/views/profile.dart';
import 'package:flag/flag.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = '';
  String buyingDropdownValue = "Ksh";
  String dropdownValue = "ush";
  double rate = 0;
  double result = 0;
  bool isBuying = true;
  bool isResult = false;
  bool isLoading = false;
  String ushName = '';
  String usdName = '';
  String flagChosen = 'UG';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                child: FlutterLogo(),
                radius: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: buyingDropdownValue,
                icon: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: isBuying ? Colors.green : Colors.orange,
                ),
                iconSize: 24,
                elevation: 16,
                style: Theme.of(context).textTheme.headline6,
                underline: Container(
                  height: 2,
                  color: isBuying ? Colors.green : Colors.orange,
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
              StreamBuilder<DocumentSnapshot>(
                stream: isBuying
                    ? FirebaseFirestore.instance
                        .collection('buyingRate')
                        .doc('6PKMVxXXAvwAxhdcDZsr')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('sellingRate')
                        .doc('dLLxgZBJkAayNKDqLOMX')
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Icon(
                      Icons.warning,
                      color: Colors.orange,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    if (data != null) {
                      ushName = 'USH: ${data['Ush']}';
                      usdName = 'USD: ${data['Usd']}';
                      return DropdownButton<String?>(
                        value: dropdownValue,
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: isBuying ? Colors.green : Colors.orange,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: Theme.of(context).textTheme.headline6,
                        underline: Container(
                          height: 2,
                          color: isBuying ? Colors.green : Colors.orange,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });

                          if (dropdownValue == 'ush') {
                            setState(() {
                              rate = double.parse('${data['Ush']}');
                            });
                          } else if (dropdownValue == 'usd') {
                            setState(() {
                              rate = double.parse('${data['Usd']}');
                            });
                          } else {
                            rate = 1.0;
                          }
                        },
                        items: <String>[
                          // TODO: change to Ush as trrhe first choice
                          'ush',
                          'usd',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    }
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '1',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: isBuying ? Colors.green : Colors.orange,
                    ),
              ),
              Text(
                dropdownValue == 'ush' ? ushName : usdName,
                // '${rate}',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: isBuying ? Colors.green : Colors.orange,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flag.fromCode(
                dropdownValue == 'ush' ? FlagsCode.UG : FlagsCode.US,
                height: 40,
                width: 70,
                fit: BoxFit.fill,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Icon(isBuying ? Icons.arrow_forward : Icons.arrow_back),
              ),
              Flag.fromCode(
                FlagsCode.KE,
                height: 40,
                width: 70,
                fit: BoxFit.fill,
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            icon: isBuying
                ? const Icon(Icons.arrow_forward)
                : const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                isBuying = !isBuying;
              });
            },
            label: Text(
              isBuying ? 'BUYING' : 'SELLING',
            ),
            style: ElevatedButton.styleFrom(
                primary: isBuying ? Colors.green : Colors.orange),
          ),
          Text(
            'RESULT',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            dropdownValue == rate
                ? 'Choose a rate'
                : '${result != 0 ? result : '_ _'} ',
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
                isLoading = true;
                if (text == '') {
                  result = 0;
                } else {
                  if (isBuying) {
                    result = (double.parse(text) * rate).toPrecision(2);
                  } else {
                    result = (double.parse(text) / rate).toPrecision(2);
                  }
                }
                String? num = FirebaseAuth.instance.currentUser!.phoneNumber;
                // print(num);
                FirebaseFirestore.instance.collection('transactions').add({
                  'number': num,
                  'rate': rate,
                  'currency': dropdownValue,
                  'isBuying': isBuying,
                  'input': double.parse(text),
                  'result': result,
                  'time': FieldValue.serverTimestamp()
                });

                isLoading = false;
              });
            },
            rightButtonFn: () {
              isLoading
                  ? text
                  : setState(() {
                      text = '';
                      result = 0;
                    });
            },
            leftIcon: isLoading
                ? const CircularProgressIndicator()
                : const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 30,
                  ),
            rightButtonColor: isLoading ? Colors.grey : Colors.red[900],
            leftButtonColor: isLoading ? Colors.grey : Colors.green,
            rightIcon: isLoading
                ? const CircularProgressIndicator()
                : const Icon(
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

extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}
