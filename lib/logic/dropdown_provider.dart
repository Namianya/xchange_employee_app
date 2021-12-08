import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';


class DropDownChangeNotifire extends ChangeNotifier {
  String dropDownValue ='UG';
  void dropDownChange(String value){
    dropDownValue = value;
    notifyListeners();
  }
  
}
final dropDownChangeNotifire = ChangeNotifierProvider<DropDownChangeNotifire>((_) => DropDownChangeNotifire());