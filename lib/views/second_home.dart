import 'dart:math';

import 'package:fare_rate_mm/logic/dropdown_provider.dart';
import 'package:fare_rate_mm/logic/text_input_change_notifire.dart';
import 'package:fare_rate_mm/models/rate.dart';
import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/views/profile.dart';
import 'package:fare_rate_mm/widgets/app_keyboard.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondHome extends ConsumerWidget {
  const SecondHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentBuyingRate = ref.watch(buyingRateData);
    final _currentSellingRate = ref.watch(sellingRateData);
    final _isByBuyingState = ref.watch(isBuyingChangeNotifier);
    final _dropdownProvider = ref.watch(dropDownChangeNotifire);
    final _inputTextChangeNotifire = ref.watch(inputTextChangeNotifire);

    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.menu),
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
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flag.fromString(
                          'KE',
                          height: 20,
                          width: 30,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'KSH',
                          style: TextStyle(
                              fontSize: 20,
                              color: _isByBuyingState.isBuying
                                  ? Colors.green
                                  : Colors.indigo),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '1',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: _isByBuyingState.isBuying
                              ? Colors.green
                              : Colors.indigo),
                    ),
                  ],
                ),
                _isByBuyingState.isBuying
                    ? _currentBuyingRate.when(
                        data: (data) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButton(
                                  value: _dropdownProvider.dropDownValue,
                                  onChanged: (String? value) {
                                    _dropdownProvider.dropDownChange(value!);
                                  },
                                  items: [
                                    'UG',
                                    'US',
                                  ]
                                      .map((e) => DropdownMenuItem(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flag.fromString(e,
                                                    height: 20,
                                                    width: 30,
                                                    fit: BoxFit.fill),
                                                SizedBox(width: 10),
                                                Text(
                                                  e,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      ?.copyWith(
                                                        color: Colors.green,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                ),
                                Text(
                                    _dropdownProvider.dropDownValue == 'US'
                                        ? data.usd
                                        : data.ush,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(color: Colors.green)),
                              ],
                            ),
                        error: (e, s) => Text('$e'),
                        loading: () => Text('Loading ...'))
                    : _currentSellingRate.when(
                        data: (data) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton(
                              value: _dropdownProvider.dropDownValue,
                              onChanged: (String? value) {
                                _dropdownProvider.dropDownChange(value!);
                              },
                              items: [
                                'UG',
                                'US',
                              ]
                                  .map((e) => DropdownMenuItem(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flag.fromString(e,
                                                height: 20,
                                                width: 30,
                                                fit: BoxFit.fill),
                                            SizedBox(width: 10),
                                            Text(e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    ?.copyWith(
                                                        color: Colors.indigo)),
                                          ],
                                        ),
                                        value: e,
                                      ))
                                  .toList(),
                            ),
                            Text(
                                _dropdownProvider.dropDownValue == 'US'
                                    ? data.usd
                                    : data.ush,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(color: Colors.indigo)),
                          ],
                        ),
                        loading: () => Text('Loading...'),
                        error: (e, s) => Text('$e'),
                      ),
              ],
            ),
            const Spacer(),
            Text('${_inputTextChangeNotifire.calculatedText}',
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      color: _inputTextChangeNotifire.inputText != ""
                          ? Colors.black
                          : Colors.grey,
                    )),
            Text(
              '${_inputTextChangeNotifire.inputText != "" ? _inputTextChangeNotifire.inputText : "Enter Amount"}',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: _inputTextChangeNotifire.inputText != ""
                        ? Colors.black
                        : Colors.grey,
                  ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => {
                _isByBuyingState.setIsBuying(),
                _inputTextChangeNotifire.reset()
              },
              style: ElevatedButton.styleFrom(
                primary:
                    _isByBuyingState.isBuying ? Colors.green : Colors.indigo,
              ),
              icon: Icon(_isByBuyingState.isBuying
                  ? Icons.arrow_forward_rounded
                  : Icons.arrow_back_rounded),
              label:
                  Text('${_isByBuyingState.isBuying ? 'BUYING' : 'SELLING'}'),
            ),
            AppKeyboard(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}
