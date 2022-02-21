import 'dart:ffi';
import 'dart:math';

import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:fare_rate_mm/services/data_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputTextChangeNotifire extends ChangeNotifier {
  String? inputText;
  double? currentRate;

  final Ref ref;

  double calculatedText = 0.00;
  Store store = Store();
  bool isAbove = false;

  InputTextChangeNotifire(this.ref);

  void onKeyboardType(String value) {
    inputText == null ? inputText = value : inputText = inputText! + value;
  //  inputText!=null || inputText!='' ? ref.watch() double.parse(inputText!)*currentRate! : 0.00;
    notifyListeners();
  }

  void onKeyboardDel() {
    inputText != null || inputText != ""
        ? inputText = inputText!.substring(0, inputText!.length - 1)
        : inputText = null;
    notifyListeners();
  }

  void calculateBuyingText(
    String? rate, {
    required String currency,
  }) {
    currentRate = double.parse(rate!);

    calculatedText =
        roundDouble(double.parse(inputText!) / double.parse(rate), 3);

    notifyListeners();
  }

  void calculateBuyingTextInvert(
    String? rate, {
    required String currency,
  }) {
    final _currentStockStreamProvider = ref.watch(currentStockStreamProvider);
    final _isBuying = ref.watch(isBuyingChangeNotifier);
    currentRate = double.parse(rate!);

    calculatedText =
        roundDouble(double.parse(inputText!) * double.parse(rate), 3);

    notifyListeners();
  }

  void calculateSellingText(
    String? rate, {
    required String currency,
  }) {
    currentRate = double.parse(rate!);
    calculatedText =
        roundDouble(double.parse(inputText!) * double.parse(rate), 3);

    notifyListeners();
  }

  void calculateSellingTextInvert(
    String? rate, {
    required String currency,
  }) {
    currentRate = double.parse(rate!);
    calculatedText =
        roundDouble(double.parse(inputText!) / double.parse(rate), 3);

    notifyListeners();
  }

  void reset() {
    inputText = null;
    calculatedText = 0.0;
    notifyListeners();
  }
}

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

final inputTextChangeNotifire =
    ChangeNotifierProvider((ref) => InputTextChangeNotifire(ref));
