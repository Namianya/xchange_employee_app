import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class IsLoadingChange extends ChangeNotifier {
  bool isLoading = false;
  void changeLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }
}

final isLoadingChangeProvider =
    ChangeNotifierProvider<IsLoadingChange>((ref) => IsLoadingChange());
