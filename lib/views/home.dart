import 'dart:math';

import 'package:fare_rate_mm/logic/dropdown_provider.dart';
import 'package:fare_rate_mm/logic/focus_change_notifire.dart';
import 'package:fare_rate_mm/logic/text_input_change_notifire.dart';
// import 'package:fare_rate_mm/models/rate.dart';
import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/network/connectivity_service.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:fare_rate_mm/views/no_network.dart';
import 'package:fare_rate_mm/views/profile.dart';
import 'package:fare_rate_mm/widgets/app_keyboard.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentBuyingRate = ref.watch(buyingRateData);
    final _currentSellingRate = ref.watch(sellingRateData);
    final _isByBuyingState = ref.watch(isBuyingChangeNotifier);
    final _dropdownProvider = ref.watch(dropDownChangeNotifire);
    final _inputTextChangeNotifire = ref.watch(inputTextChangeNotifire);
    final _focusChangeNotifierProvider = ref.watch(focusChangeNotifierProvider);
    final _connectivityStreamProvider = ref.watch(connectivityStreamProvider);
    final _currentStockStreamProvider = ref.watch(currentStockStreamProvider);
    var f = NumberFormat("#,###,###,###.0#", "en_US");
    return _connectivityStreamProvider.value == ConnectivityStatus.WiFi ||
            _connectivityStreamProvider.value == ConnectivityStatus.Cellular
        ? Scaffold(
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
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
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
                                          _dropdownProvider
                                              .dropDownChange(value!);
                                        },
                                        items: [
                                          'UG',
                                          'US',
                                        ]
                                            .map((e) => DropdownMenuItem(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  value: e,
                                                ))
                                            .toList(),
                                      ),
                                      Text(
                                          _dropdownProvider.dropDownValue ==
                                                  'US'
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
                                                              color: Colors
                                                                  .indigo)),
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
                              error: (e, s) => Text('Stock Error'),
                            ),
                    ],
                  ),
                  const Spacer(),

                  // !when focused
                  _focusChangeNotifierProvider.isFocused
                      ? Column(
                          children: [
                            Text(
                              '${_inputTextChangeNotifire.inputText ?? "Enter Amount in"}' +
                                  "  ${_isByBuyingState.isBuying ? _dropdownProvider.dropDownValue == 'US' ? 'USD' : 'USH' : 'KE'}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    color: _inputTextChangeNotifire.inputText !=
                                            null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${f.format(_inputTextChangeNotifire.calculatedText)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: _inputTextChangeNotifire
                                                    .inputText !=
                                                ""
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                _isByBuyingState.isBuying
                                    ? Text(
                                        _isByBuyingState.isBuying
                                            ? 'KSH'
                                            : _dropdownProvider.dropDownValue ==
                                                    'US'
                                                ? 'USD'
                                                : 'USH',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              color: _inputTextChangeNotifire
                                                          .inputText !=
                                                      ""
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                      )
                                    : Text(
                                        _isByBuyingState.isBuying
                                            ? 'KSH'
                                            : _dropdownProvider.dropDownValue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              color: _inputTextChangeNotifire
                                                          .inputText !=
                                                      ""
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                      )
                              ],
                            ),
                          ],
                        )
                      :
                      // !if not focused
                      Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${f.format(_inputTextChangeNotifire.calculatedText)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: _inputTextChangeNotifire
                                                    .inputText !=
                                                ""
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                _isByBuyingState.isBuying
                                    ? Text(
                                        _dropdownProvider.dropDownValue == 'US'
                                            ? 'USD'
                                            : 'USH',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              color: _inputTextChangeNotifire
                                                          .inputText !=
                                                      ""
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                      )
                                    : Text(
                                        'KSH',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              color: _inputTextChangeNotifire
                                                          .inputText !=
                                                      ""
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                      )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${_inputTextChangeNotifire.inputText?.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') ?? "Enter Amount"}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    color: _inputTextChangeNotifire.inputText !=
                                            null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                            ),
                          ],
                        ),

                  const Spacer(),
                  _currentStockStreamProvider.when(
                    data: (data) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '  KSH:  ${roundDouble4(data.ksh)}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontSize: 16),
                        ),
                        Text(
                          '  USH:  ${roundDouble4(data.ush)}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontSize: 16),
                        ),
                        Text(
                          '  USD:  ${roundDouble4(data.usd)}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    error: (Object error, StackTrace? stackTrace) =>
                        //? Text('err: $error'),
                        Text(
                      'Current Stock dissabled by developer',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    loading: () => Text('Loading'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => {
                          _inputTextChangeNotifire.reset(),
                          _isByBuyingState.setIsBuying(),
                        },
                        style: ElevatedButton.styleFrom(
                          primary: _isByBuyingState.isBuying
                              ? Colors.green
                              : Colors.indigo,
                        ),
                        icon: Icon(_isByBuyingState.isBuying
                            ? Icons.arrow_forward_rounded
                            : Icons.arrow_back_rounded),
                        label: Text(
                            '${_isByBuyingState.isBuying ? 'BUYING' : 'SELLING'}'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => {
                          _inputTextChangeNotifire.reset(),
                          _focusChangeNotifierProvider.setFocus(),
                        },
                        style: ElevatedButton.styleFrom(
                            primary: _focusChangeNotifierProvider.isFocused
                                ? Colors.blue
                                : Colors.grey),
                        icon: Icon(Icons.swap_vertical_circle_outlined),
                        label: Text(
                            '${_isByBuyingState.isBuying ? _dropdownProvider.dropDownValue : 'KE'}'
                                .toUpperCase()),
                      ),
                    ],
                  ),
                  AppKeyboard(
                    onKeyboardTap: (text) => (print(text)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        : const NoNetwork();
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}

double roundDouble4(double value) {
  num mod = pow(10.0, 2);
  return ((value * mod).round().toDouble() / mod);
}
