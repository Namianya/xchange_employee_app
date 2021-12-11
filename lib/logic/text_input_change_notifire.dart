import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputTextChangeNotifire extends ChangeNotifier {
  String? inputText;
  double? currentRate;

  double calculatedText = 0.0;

  void onKeyboardType(String value) {
    inputText == null ? inputText = value : inputText = inputText! + value;
    notifyListeners();
  }

  void calculateBuyingText(String? rate) {
    currentRate = double.parse(rate!);

    calculatedText = double.parse(inputText!) / double.parse(rate);

    notifyListeners();
  }

  void calculateSellingText(String? rate) {
    currentRate = double.parse(rate!);
    calculatedText = double.parse(inputText!) * double.parse(rate);

    notifyListeners();
  }

  void reset() {
    inputText = null;
    calculatedText = 0.0;
    notifyListeners();
  }
}

final inputTextChangeNotifire =
    ChangeNotifierProvider((ref) => InputTextChangeNotifire());
