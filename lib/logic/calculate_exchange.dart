import 'package:flutter/material.dart';

class CalculateInputChangeNotifier extends ChangeNotifier {
  

  void updateInput(String input) {
    input = input;
    notifyListeners();
  }
}
