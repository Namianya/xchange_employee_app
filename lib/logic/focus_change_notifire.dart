import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FocusChangeNotifier extends ChangeNotifier {
  bool _isFocused = false;

  bool get isFocused => _isFocused;

  void setFocus(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  
}

final focusChangeNotifierProvider = ChangeNotifierProvider<FocusChangeNotifier>((ref) {
  return FocusChangeNotifier();
});