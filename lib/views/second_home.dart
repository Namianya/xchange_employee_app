import 'dart:math';

import 'package:fare_rate_mm/logic/dropdown_provider.dart';
import 'package:fare_rate_mm/logic/focus_change_notifire.dart';
// import 'package:fare_rate_mm/models/rate.dart';
import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/logic/text_input_change_notifire.dart';
import 'package:fare_rate_mm/network/connectivity_service.dart';
import 'package:fare_rate_mm/network/connectivity_status.dart';
import 'package:fare_rate_mm/views/no_network.dart';
import 'package:fare_rate_mm/views/profile.dart';
import 'package:fare_rate_mm/widgets/app_keyboard.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/focused_ui.dart';
import '../widgets/not_focused_ui.dart';

class SecondHome extends ConsumerWidget {
  const SecondHome({Key? key}) : super(key: key);

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
    // var f = NumberFormat("#,###,###,##0.0#", "en_US");
    return _connectivityStreamProvider.when(
      data: (data) => data == ConnectivityStatus.WiFi ||
              data == ConnectivityStatus.Cellular
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
                                          value:
                                              _dropdownProvider.dropDownValue,
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
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6
                                                                  ?.copyWith(
                                                                    color: Colors
                                                                        .green,
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
                                                ?.copyWith(
                                                    color: Colors.green)),
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
                        ? FocusedUI()
                        : NotFocusedUI(),

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
                            backgroundColor: _isByBuyingState.isBuying
                                ? Colors.green
                                : Colors.indigo,
                          ),
                          icon: Icon(_isByBuyingState.isBuying
                              ? Icons.arrow_forward_rounded
                              : Icons.arrow_back_rounded),
                          label: Text(
                              '${_isByBuyingState.isBuying ? 'SELLING KSH' : _dropdownProvider.dropDownValue == 'US' ? 'BUYING USD' : 'BUYING UGX'}'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => {
                            _inputTextChangeNotifire.reset(),
                            _focusChangeNotifierProvider.setFocus(),
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _focusChangeNotifierProvider.isFocused
                                      ? Colors.grey
                                      : Colors.blue),
                          icon: Icon(Icons.swap_vertical_circle_outlined),
                          label: Text(
                              '${_isByBuyingState.isBuying ? 'KE' : _dropdownProvider.dropDownValue}'
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
          : const NoNetwork(),
      loading: () => Scaffold(
        body: const Center(
          child: Text('Loading ...'),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: const Center(
          child: Text('Loading ...'),
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

double roundDouble4(double value) {
  num mod = pow(10.0, 2);
  return ((value * mod).round().toDouble() / mod);
}
