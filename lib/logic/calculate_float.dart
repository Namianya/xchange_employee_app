// import 'package:fare_rate_mm/logic/dropdown_provider.dart';
// import 'package:fare_rate_mm/logic/riverpod_providers.dart';
// import 'package:fare_rate_mm/logic/text_input_change_notifire.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'focus_change_notifire.dart';

// class CalculateFloat extends ChangeNotifier {
//   bool _isLow = false;
//   double _value = 0.0;
//   double get value => _value;
//   bool get isShow => _isLow;
//   late Ref ref;
//   CalculateFloat();

//   void add(double value) {
//     _value += value;
//     notifyListeners();
//   }

//   void calculate(double value) {
//     final _buyingRateData = ref.watch(buyingRateData).value;
//     final _currentSellingRate = ref.watch(sellingRateData).value;
//     final _isByBuyingState = ref.watch(isBuyingChangeNotifier).isBuying;
//     final _dropdownProvider = ref.watch(dropDownChangeNotifire).dropDownValue;
//     final _focusChangeNotifierProvider = ref.watch(focusChangeNotifierProvider);
//     final _inputTextChangeNotifire = ref.watch(inputTextChangeNotifire);
//     final _currentStockStreamProvider = ref.watch(currentStockStreamProvider);

//     if (! _isByBuyingState) {
   
//     notifyListeners();
//     } else {
    
//     }
      
      
   
//     _value = value;
//     notifyListeners();
//   }

  

//   void reset() {
//     _value = 0.0;
//     notifyListeners();
//   }
// }
