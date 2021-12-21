import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputTextChangeNotifire extends ChangeNotifier {
  String? inputText;
  double? currentRate;

  double calculatedText = 0.00;

  void onKeyboardType(String value) {
    inputText == null ? inputText = value : inputText = inputText! + value;
    notifyListeners();
  }

  void calculateBuyingText(String? rate) {
    currentRate = double.parse(rate!);

    calculatedText =
        roundDouble(double.parse(inputText!) / double.parse(rate), 3);

    notifyListeners();
  }

  void calculateSellingText(String? rate) {
    currentRate = double.parse(rate!);
    calculatedText =
        roundDouble(double.parse(inputText!) * double.parse(rate), 3);

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
    ChangeNotifierProvider((ref) => InputTextChangeNotifire());
