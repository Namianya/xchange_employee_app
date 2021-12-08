import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputTextChangeNotifire extends ChangeNotifier {
  String inputText = "";

  double calculatedText = 0.0;

  void onKeyboardType(String value) {
    inputText = inputText + value;
    notifyListeners();
  }

  void calculateBuyingText(String? rate) {
    calculatedText = double.parse(inputText) / double.parse(rate!);

    notifyListeners();
  }

  void calculateSellingText(String? rate) {
    calculatedText = double.parse(inputText) * double.parse(rate!);

    notifyListeners();
  }

  void reset() {
    inputText = "";
    calculatedText = 0.0;
    notifyListeners();
  }
}

final inputTextChangeNotifire =
    ChangeNotifierProvider((ref) => InputTextChangeNotifire());
