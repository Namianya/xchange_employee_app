library my_keyboard;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fare_rate_mm/logic/dropdown_provider.dart';
import 'package:fare_rate_mm/logic/focus_change_notifire.dart';
import 'package:fare_rate_mm/logic/loading_change_provider.dart';
import 'package:fare_rate_mm/logic/text_input_change_notifire.dart';
import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/models/tranasction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/data_store.dart';

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
    final _currentBuyingRate = ref.watch(buyingRateData);
    final _currentSellingRate = ref.watch(sellingRateData);
    final _dropdownProvider = ref.watch(dropDownChangeNotifire);
    final _isLoadingProvider = ref.watch(isLoadingChangeProvider);
    final _currentStockStreamProvider = ref.watch(currentStockStreamProvider);
    final _focusChangeNotifierProvider = ref.watch(focusChangeNotifierProvider);
    late double _fromAmount;
    late double _toAmount;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Store _store = Store();

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
              _calcButton('DEL', context),
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
                onTap: () => _inputTextChangeNotifire.reset(),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: rightButtonColor ?? Colors.red[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: size.width * 0.4,
                  height: 60,
                  child: Text(
                    'CLEAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _isByBuyingState.isBuying
                  ? _currentBuyingRate.when(
                      data: (data) => _inputTextChangeNotifire.calculatedText !=
                              0
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
                              splashColor: Colors.green[900],
                              borderRadius: BorderRadius.circular(5),
                              onTap: _inputTextChangeNotifire.inputText != null
                                  ? () => {
                                        _dropdownProvider.dropDownValue == 'US'
                                            ? _focusChangeNotifierProvider
                                                    .isFocused
                                                ? _inputTextChangeNotifire
                                                    .calculateBuyingTextInvert(
                                                    _dropdownProvider
                                                                .dropDownValue ==
                                                            'UG'
                                                        ? data.ush
                                                        : data.usd,
                                                    currency: _dropdownProvider
                                                        .dropDownValue,
                                                  )
                                                : _inputTextChangeNotifire
                                                    .calculateBuyingText(
                                                    _dropdownProvider
                                                                .dropDownValue ==
                                                            'UG'
                                                        ? data.ush
                                                        : data.usd,
                                                    currency: _dropdownProvider
                                                        .dropDownValue,
                                                  )
                                            // !!
                                            : _focusChangeNotifierProvider
                                                    .isFocused
                                                ? _inputTextChangeNotifire
                                                    .calculateSellingTextInvert(
                                                    _dropdownProvider
                                                                .dropDownValue ==
                                                            'UG'
                                                        ? data.ush
                                                        : data.usd,
                                                    currency: _dropdownProvider
                                                        .dropDownValue,
                                                  )
                                                : _inputTextChangeNotifire
                                                    .calculateSellingText(
                                                    _dropdownProvider
                                                                .dropDownValue ==
                                                            'UG'
                                                        ? data.ush
                                                        : data.usd,
                                                    currency: _dropdownProvider
                                                        .dropDownValue,
                                                  ),
                                        _isLoadingProvider.changeLoadingState(),
                                        _store.updateCurrentStock(
                                          from: _focusChangeNotifierProvider
                                                  .isFocused
                                              ? _currentStockStreamProvider
                                                      .value!.ksh +
                                                  _inputTextChangeNotifire
                                                      .calculatedText
                                              : _currentStockStreamProvider
                                                      .value!.ksh +
                                                  double.parse(
                                                      _inputTextChangeNotifire
                                                          .inputText!),
                                          to: _focusChangeNotifierProvider
                                                  .isFocused
                                              ? _dropdownProvider
                                                          .dropDownValue ==
                                                      'UG'
                                                  ? _currentStockStreamProvider
                                                          .value!.ush -
                                                      double.parse(
                                                          _inputTextChangeNotifire
                                                              .inputText!)
                                                  : _currentStockStreamProvider
                                                          .value!.usd -
                                                      double.parse(
                                                          _inputTextChangeNotifire
                                                              .inputText!)
                                              : _dropdownProvider
                                                          .dropDownValue ==
                                                      'UG'
                                                  ? _currentStockStreamProvider
                                                          .value!.ush -
                                                      _inputTextChangeNotifire
                                                          .calculatedText
                                                  : _currentStockStreamProvider
                                                          .value!.usd -
                                                      _inputTextChangeNotifire
                                                          .calculatedText,
                                          fromName: 'ksh',
                                          toName:
                                              _dropdownProvider.dropDownValue ==
                                                      'UG'
                                                  ? 'ush'
                                                  : 'usd',
                                        ),
//  TODO:slove this
                                        FirebaseFirestore.instance
                                            .collection('transactions')
                                            .add(
                                              TransactionModel(
                                                      userNumber: FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .phoneNumber,
                                                      currency: _dropdownProvider
                                                          .dropDownValue,
                                                      // ? chnges done here
                                                      finalValue: _focusChangeNotifierProvider
                                                              .isFocused
                                                          ? double.parse(
                                                              _inputTextChangeNotifire
                                                                  .inputText!)
                                                          : _inputTextChangeNotifire
                                                              .calculatedText,
                                                      initialValue: _focusChangeNotifierProvider
                                                              .isFocused
                                                          ? _inputTextChangeNotifire
                                                              .calculatedText
                                                          : double.parse(
                                                              _inputTextChangeNotifire
                                                                  .inputText!),
                                                      isBuying: _isByBuyingState
                                                          .isBuying,
                                                      rate:
                                                          _inputTextChangeNotifire
                                                              .currentRate!,
                                                      transactionTime: FieldValue
                                                          .serverTimestamp())
                                                  .toMap(),
                                            )
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.white,
                                              content: Text(
                                                'Successful',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ),
                                          );
                                        }).catchError((e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.white,
                                              content: Text(
                                                'Something went wrong, please try again',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          );
                                        }),
                                        _isLoadingProvider.changeLoadingState(),
                                      }
                                  : () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                        color: Colors.green,
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
                  : _currentSellingRate.when(
                      data: (data) => InkWell(
                            splashColor: Colors.green[900],
                            borderRadius: BorderRadius.circular(5),
                            onTap: _inputTextChangeNotifire.inputText != null
                                ? () => {
                                      _dropdownProvider.dropDownValue == 'US'
                                          ? _focusChangeNotifierProvider
                                                  .isFocused
                                              ? _inputTextChangeNotifire
                                                  .calculateSellingTextInvert(
                                                  _dropdownProvider
                                                              .dropDownValue ==
                                                          'UG'
                                                      ? data.ush
                                                      : data.usd,
                                                  currency: _dropdownProvider
                                                      .dropDownValue,
                                                )
                                              : _inputTextChangeNotifire
                                                  .calculateSellingText(
                                                  _dropdownProvider
                                                              .dropDownValue ==
                                                          'UG'
                                                      ? data.ush
                                                      : data.usd,
                                                  currency: _dropdownProvider
                                                      .dropDownValue,
                                                )
                                          // !
                                          : _focusChangeNotifierProvider
                                                  .isFocused
                                              ? _inputTextChangeNotifire
                                                  .calculateBuyingTextInvert(
                                                  _dropdownProvider
                                                              .dropDownValue ==
                                                          'UG'
                                                      ? data.ush
                                                      : data.usd,
                                                  currency: _dropdownProvider
                                                      .dropDownValue,
                                                )
                                              : _inputTextChangeNotifire
                                                  .calculateBuyingText(
                                                  _dropdownProvider
                                                              .dropDownValue ==
                                                          'UG'
                                                      ? data.ush
                                                      : data.usd,
                                                  currency: _dropdownProvider
                                                      .dropDownValue,
                                                ),
                                      _isLoadingProvider.changeLoadingState(),
                                      // todo: add a snackbar

                                      firestore
                                          .collection('transactions')
                                          .add(
                                            TransactionModel(
                                                    userNumber: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .phoneNumber,
                                                    currency: _dropdownProvider
                                                        .dropDownValue,
                                                    finalValue: _focusChangeNotifierProvider
                                                            .isFocused
                                                        ? double.parse(
                                                            _inputTextChangeNotifire
                                                                .inputText!)
                                                        : _inputTextChangeNotifire
                                                            .calculatedText,
                                                    initialValue:
                                                        _focusChangeNotifierProvider
                                                                .isFocused
                                                            ? _inputTextChangeNotifire
                                                                .calculatedText
                                                            : double.parse(
                                                                _inputTextChangeNotifire
                                                                    .inputText!),
                                                    isBuying: _isByBuyingState
                                                        .isBuying,
                                                    rate:
                                                        _inputTextChangeNotifire
                                                            .currentRate!,
                                                    transactionTime: FieldValue
                                                        .serverTimestamp())
                                                .toMap(),
                                          )
                                          .then((value) {
                                        _store.updateCurrentStock(
                                          from: _focusChangeNotifierProvider
                                                  .isFocused
                                              ? _dropdownProvider
                                                          .dropDownValue ==
                                                      'UG'
                                                  ? _currentStockStreamProvider
                                                          .value!.ush +
                                                      ref
                                                          .watch(
                                                              inputTextChangeNotifire)
                                                          .calculatedText
                                                  : _currentStockStreamProvider
                                                          .value!.usd +
                                                      ref
                                                          .watch(
                                                              inputTextChangeNotifire)
                                                          .calculatedText
                                              : _dropdownProvider
                                                          .dropDownValue ==
                                                      'UG'
                                                  ? _currentStockStreamProvider
                                                          .value!.ush +
                                                      double.parse(ref
                                                          .watch(
                                                              inputTextChangeNotifire)
                                                          .inputText!)
                                                  : _currentStockStreamProvider
                                                          .value!.usd +
                                                      double.parse(ref
                                                          .watch(
                                                              inputTextChangeNotifire)
                                                          .inputText!),
                                          to: _focusChangeNotifierProvider
                                                  .isFocused
                                              ? _currentStockStreamProvider
                                                      .value!.ksh -
                                                  double.parse(ref
                                                      .watch(
                                                          inputTextChangeNotifire)
                                                      .inputText!)
                                              : _currentStockStreamProvider
                                                      .value!.ksh -
                                                  ref
                                                      .watch(
                                                          inputTextChangeNotifire)
                                                      .calculatedText,
                                          fromName:
                                              _dropdownProvider.dropDownValue ==
                                                      'UG'
                                                  ? 'ush'
                                                  : 'usd',
                                          toName: 'ksh',
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.white,
                                            content: Text(
                                              'Successful',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        );
                                      }).catchError((e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.white,
                                            content: Text(
                                              'Something went wrong, please try again',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        );
                                      }),

                                      _isLoadingProvider.changeLoadingState(),
                                    }
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
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.indigo,
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
                      loading: () => Text('Loading ...')),
            ],
          )
        ],
      ),
    );
  }
}
