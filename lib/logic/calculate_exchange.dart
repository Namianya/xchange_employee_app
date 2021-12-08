import 'package:fare_rate_mm/logic/text_input_change_notifire.dart';
import 'package:flutter/material.dart';

class CalculateInputChangeNotifier extends ChangeNotifier {
  

  void updateInput(String input) {
    input = input;
    notifyListeners();
  }
}
