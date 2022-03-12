library my_keyboard;

import 'dart:math';

import 'package:fare_rate_mm/logic/dropdown_provider.dart';
import 'package:fare_rate_mm/logic/focus_change_notifire.dart';
import 'package:fare_rate_mm/logic/loading_change_provider.dart';
import 'package:fare_rate_mm/logic/text_input_change_notifire.dart';
import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/widgets/new_buy_sell_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef KeyboardTapCallback = void Function(String text);

class AppKeyboard extends ConsumerWidget {
  final Color textColor;
  final Color? leftButtonColor;
  final Color? rightButtonColor;

  final Widget? rightIcon;

  final Function()? rightButtonFn;

  final Widget? leftIcon;

  final Function()? leftButtonFn;

  final KeyboardTapCallback? onKeyboardTap;

  final MainAxisAlignment mainAxisAlignment;

  const AppKeyboard(
      {Key? key,
      this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
      this.leftButtonColor,
      this.rightButtonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    final _isByBuyingState = ref.watch(isBuyingChangeNotifier);
    final _inputTextChangeNotifire = ref.watch(inputTextChangeNotifire);
    final _inputTextChangeNotifire2 = ref.watch(inputTextChangeNotifire);
    final _currentBuyingRate = ref.watch(buyingRateData);
    final _currentSellingRate = ref.watch(sellingRateData);
    final _dropdownProvider = ref.watch(dropDownChangeNotifire);
    final _isLoadingProvider = ref.watch(isLoadingChangeProvider);
    final _currentStockStreamProvider = ref.watch(currentStockStreamProvider);
    final _focusChangeNotifierProvider = ref.watch(focusChangeNotifierProvider);
    final _postToFirebase = ref.watch(postToFirebaseProvider);

    Widget _calcButton(String value, BuildContext context) {
      return InkWell(
        splashColor: Colors.grey[100],
        // onTap: () => _inputTextChangeNotifire.onKeyboardType(value),
        onTap: () => value == 'DEL'
            ? _inputTextChangeNotifire.onKeyboardDel()
            : _inputTextChangeNotifire.onKeyboardType(value),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 1 / 3,
          height: 70,
          child: Text(value,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: value == 'DEL' ? Colors.red : Colors.black)),
        ),
      );
    }

    void buySell() {
      if (_isByBuyingState.isBuying) {
        if (_focusChangeNotifierProvider.isFocused) {
          _dropdownProvider.dropDownValue == 'UG'
              ? _inputTextChangeNotifire.calculateSellingTextInvert(
                  _currentBuyingRate.value!.ush,
                  currency: _dropdownProvider.dropDownValue,
                )
              : _inputTextChangeNotifire.calculateBuyingTextInvert(
                  _currentBuyingRate.value!.usd,
                  currency: _dropdownProvider.dropDownValue,
                );
          // ?
          if (_dropdownProvider.dropDownValue == 'UG' &&
              _currentStockStreamProvider.value!.ush <
                  double.parse(_inputTextChangeNotifire.inputText!)) {
            _inputTextChangeNotifire.inputText = null;
            _inputTextChangeNotifire.calculatedText = 0;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 4000),
                backgroundColor: Colors.white,
                content: Text(
                  ' USH float is not enough',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (_dropdownProvider.dropDownValue == 'US' &&
              _currentStockStreamProvider.value!.usd <
                  double.parse(_inputTextChangeNotifire.inputText!)) {
            _inputTextChangeNotifire.inputText = null;
            _inputTextChangeNotifire.calculatedText = 0;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 4000),
                backgroundColor: Colors.white,
                content: Text(
                  'Too low float',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          } else {
            addTransactionToFirebase(
              isBuying: true,
              rate: _inputTextChangeNotifire.currentRate!,
              context: context,
              currency: _dropdownProvider.dropDownValue,
              initialVal: roundDouble(_inputTextChangeNotifire.calculatedText),
              finalVal: double.parse(_inputTextChangeNotifire.inputText!),
            );
            updateCurrentStock(
              context: context,
              from: _currentStockStreamProvider.value!.ksh +
                  roundDouble(_inputTextChangeNotifire2.calculatedText),
              to: _dropdownProvider.dropDownValue == 'UG'
                  ? _currentStockStreamProvider.value!.ush -
                      double.parse(_inputTextChangeNotifire2.inputText!)
                  : _currentStockStreamProvider.value!.usd -
                      double.parse(_inputTextChangeNotifire2.inputText!),
              fromName: 'ksh',
              toName: _dropdownProvider.dropDownValue == 'UG' ? 'ush' : 'usd',
            );
          }
        } else {
          _dropdownProvider.dropDownValue == 'UG'
              ? _inputTextChangeNotifire.calculateSellingText(
                  _currentBuyingRate.value!.ush,
                  currency: _dropdownProvider.dropDownValue,
                )
              : _inputTextChangeNotifire.calculateBuyingText(
                  _currentBuyingRate.value!.usd,
                  currency: _dropdownProvider.dropDownValue,
                );

          // ?
          if (_dropdownProvider.dropDownValue == 'UG' &&
              _currentStockStreamProvider.value!.ush <
                  _inputTextChangeNotifire.calculatedText) {
            _inputTextChangeNotifire.calculatedText = 0;
            _inputTextChangeNotifire.inputText = null;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 4000),
                backgroundColor: Colors.white,
                content: Text(
                  ' USH float is not enough',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (_dropdownProvider.dropDownValue == 'US' &&
              _currentStockStreamProvider.value!.usd <
                  _inputTextChangeNotifire.calculatedText) {
            _inputTextChangeNotifire.calculatedText = 0;
            _inputTextChangeNotifire.inputText = null;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 4000),
                backgroundColor: Colors.white,
                content: Text(
                  'Too low float',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          } else {
            addTransactionToFirebase(
              isBuying: true,
              rate: _inputTextChangeNotifire.currentRate!,
              context: context,
              currency: _dropdownProvider.dropDownValue,
              finalVal: roundDouble(_inputTextChangeNotifire.calculatedText),
              initialVal: double.parse(_inputTextChangeNotifire.inputText!),
            );
            updateCurrentStock(
              context: context,
              from: _currentStockStreamProvider.value!.ksh +
                  double.parse(_inputTextChangeNotifire2.inputText!),
              to: _dropdownProvider.dropDownValue == 'UG'
                  ? _currentStockStreamProvider.value!.ush -
                      roundDouble(_inputTextChangeNotifire2.calculatedText)
                  : _currentStockStreamProvider.value!.usd -
                      roundDouble(_inputTextChangeNotifire2.calculatedText),
              fromName: 'ksh',
              toName: _dropdownProvider.dropDownValue == 'UG' ? 'ush' : 'usd',
            );
          }
        }
      } else {
        // selling
        if (_focusChangeNotifierProvider.isFocused) {
          // is focussed
          if (_dropdownProvider.dropDownValue == 'UG') {
            _inputTextChangeNotifire.calculateBuyingTextInvert(
              _currentSellingRate.value!.ush,
              currency: _dropdownProvider.dropDownValue,
            );
          } else {
            _inputTextChangeNotifire.calculateSellingTextInvert(
              _currentSellingRate.value!.usd,
              currency: _dropdownProvider.dropDownValue,
            );
          }

// ?
          if (_currentStockStreamProvider.value!.ksh <
              double.parse(_inputTextChangeNotifire.inputText!)) {
            _inputTextChangeNotifire.calculatedText = 0;
            _inputTextChangeNotifire.inputText = null;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 4000),
                backgroundColor: Colors.white,
                content: Text(
                  ' KSH float is not enough',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          } else {
            addTransactionToFirebase(
              isBuying: false,
              rate: _inputTextChangeNotifire.currentRate!,
              context: context,
              currency: _dropdownProvider.dropDownValue,
              initialVal: roundDouble(_inputTextChangeNotifire.calculatedText),
              finalVal: double.parse(_inputTextChangeNotifire.inputText!),
            );

// *
// *
// *
            _postToFirebase.updateCurrentStock(context: context);
            // updateCurrentStock(
            //   context: context,
            //   to: _currentStockStreamProvider.value!.ksh -
            //       double.parse(_inputTextChangeNotifire2.inputText!),
            //   from: _dropdownProvider.dropDownValue == 'UG'
            //       ? _currentStockStreamProvider.value!.ush +
            //           roundDouble(_inputTextChangeNotifire2.calculatedText)
            //       : _currentStockStreamProvider.value!.usd +
            //           roundDouble(_inputTextChangeNotifire2.calculatedText),
            //   toName: 'ksh',
            //   fromName: _dropdownProvider.dropDownValue == 'UG' ? 'ush' : 'usd',
            // );
          }
        } else {
          // ! is selling !focused
          _dropdownProvider.dropDownValue == 'UG'
              ? _inputTextChangeNotifire.calculateBuyingText(
                  _currentSellingRate.value!.ush,
                  currency: _dropdownProvider.dropDownValue,
                )
              : _inputTextChangeNotifire.calculateSellingText(
                  _currentSellingRate.value!.usd,
                  currency: _dropdownProvider.dropDownValue,
                );

//  ?
          if (_currentStockStreamProvider.value!.ksh <
              _inputTextChangeNotifire.calculatedText) {
            _inputTextChangeNotifire.calculatedText = 0;
            _inputTextChangeNotifire.inputText = null;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 4000),
                backgroundColor: Colors.white,
                content: Text(
                  ' KSH float is not enough',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          } else {
            addTransactionToFirebase(
              isBuying: false,
              rate: _inputTextChangeNotifire.currentRate!,
              context: context,
              currency: _dropdownProvider.dropDownValue,
              finalVal: roundDouble(_inputTextChangeNotifire.calculatedText),
              initialVal: double.parse(_inputTextChangeNotifire.inputText!),
            );
            updateCurrentStock(
              context: context,
              to: _currentStockStreamProvider.value!.ksh -
                  roundDouble(_inputTextChangeNotifire2.calculatedText),
              from: _dropdownProvider.dropDownValue == 'UG'
                  ? _currentStockStreamProvider.value!.ush +
                      double.parse(_inputTextChangeNotifire2.inputText!)
                  : _currentStockStreamProvider.value!.usd +
                      double.parse(_inputTextChangeNotifire2.inputText!),
              toName: 'ksh',
              fromName: _dropdownProvider.dropDownValue == 'UG' ? 'ush' : 'usd',
            );
          }
        }
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              _calcButton('1', context),
              _calcButton('2', context),
              _calcButton('3', context),
            ],
          ),
          Row(
            children: [
              _calcButton('4', context),
              _calcButton('5', context),
              _calcButton('6', context),
            ],
          ),
          Row(
            children: [
              _calcButton('7', context),
              _calcButton('8', context),
              _calcButton('9', context),
            ],
          ),
          Row(
            children: <Widget>[
              _calcButton('00', context),
              _calcButton('0', context),
              _calcButton('.', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                splashColor: Colors.red[900],
                borderRadius: BorderRadius.circular(5),
                onTap: () => _inputTextChangeNotifire.calculatedText != 0
                    ? _inputTextChangeNotifire.reset()
                    : _inputTextChangeNotifire.onKeyboardDel(),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: rightButtonColor ?? Colors.red[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: size.width * 0.4,
                  height: 60,
                  child: Text(
                    _inputTextChangeNotifire.calculatedText != 0
                        ? 'CLEAR'
                        : 'DELETE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _currentBuyingRate.when(
                  data: (data) => _inputTextChangeNotifire.calculatedText !=
                              0 ||
                          _inputTextChangeNotifire.inputText == null
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: size.width * 0.4,
                          height: 60,
                          child: _isLoadingProvider.isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  'CALCULATE',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        )
                      : InkWell(
                          splashColor: _isByBuyingState.isBuying
                              ? Colors.green[900]
                              : Colors.indigo[900],
                          borderRadius: BorderRadius.circular(5),
                          onTap: _inputTextChangeNotifire.inputText != null
                              ? () => buySell()
                              : () =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                        'Please enter a value',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                          child: _isLoadingProvider.isLoading
                              ? const CircularProgressIndicator()
                              : Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _isByBuyingState.isBuying
                                        ? Colors.green
                                        : Colors.indigo,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: size.width * 0.4,
                                  height: 60,
                                  child: _isLoadingProvider.isLoading
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          'CALCULATE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                        ),
                  error: (e, s) => Text('$e'),
                  loading: () => Text('Loading ...'))
            ],
          )
        ],
      ),
    );
  }
}

double roundDouble(double value) {
  num mod = pow(10.0, 2);
  return ((value * mod).round().toDouble() / mod);
}
