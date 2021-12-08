library my_keyboard;

import 'package:fare_rate_mm/logic/dropdown_provider.dart';
import 'package:fare_rate_mm/logic/text_input_change_notifire.dart';
import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef KeyboardTapCallback = void Function(String text);

class AppKeyboard extends ConsumerWidget {
  final Color textColor;
  final Color? leftButtonColor;
  final Color? rightButtonColor;

  final Widget? rightIcon;

  final Function()? rightButtonFn;

  final Widget? leftIcon;

  final Function()? leftButtonFn;

  final KeyboardTapCallback? onKeyboardTap;

  final MainAxisAlignment mainAxisAlignment;

  const AppKeyboard(
      {Key? key,
      this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
      this.leftButtonColor,
      this.rightButtonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    final _isByBuyingState = ref.watch(isBuyingChangeNotifier);
    final _inputTextChangeNotifire = ref.watch(inputTextChangeNotifire);
    final _currentBuyingRate = ref.watch(buyingRateData);
    final _currentSellingRate = ref.watch(sellingRateData);
    final _dropdownProvider = ref.watch(dropDownChangeNotifire);

    Widget _calcButton(String value, BuildContext context) {
      return InkWell(
        splashColor: Colors.grey[100],
        onTap: () => _inputTextChangeNotifire.onKeyboardType(value),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 1 / 3,
          height: 70,
          child: Text(value,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black)),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              _calcButton('1', context),
              _calcButton('2', context),
              _calcButton('3', context),
            ],
          ),
          Row(
            children: [
              _calcButton('4', context),
              _calcButton('5', context),
              _calcButton('6', context),
            ],
          ),
          Row(
            children: [
              _calcButton('7', context),
              _calcButton('8', context),
              _calcButton('9', context),
            ],
          ),
          Row(
            children: <Widget>[
              _calcButton('00', context),
              _calcButton('0', context),
              _calcButton('.', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                splashColor: Colors.red[900],
                borderRadius: BorderRadius.circular(5),
                onTap: () => _inputTextChangeNotifire.reset(),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: rightButtonColor ?? Colors.red[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: size.width * 0.4,
                  height: 60,
                  child: Text(
                    'CLEAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _isByBuyingState.isBuying
                  ? _currentBuyingRate.when(
                      data: (data) => InkWell(
                            splashColor: Colors.green[900],
                            borderRadius: BorderRadius.circular(5),
                            onTap: () => _dropdownProvider.dropDownValue == 'US'
                                ? _inputTextChangeNotifire.calculateBuyingText(
                                    _dropdownProvider.dropDownValue == 'UG'
                                        ? data.ush
                                        : data.usd,
                                  )
                                : _inputTextChangeNotifire.calculateSellingText(
                                    _dropdownProvider.dropDownValue == 'UG'
                                        ? data.ush
                                        : data.usd,
                                  ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: size.width * 0.4,
                              height: 60,
                              child: Text(
                                'CALCULATE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      error: (e, s) => Text('$e'),
                      loading: () => Text('Loading ...'))
                  : _currentSellingRate.when(
                      data: (data) => InkWell(
                            splashColor: Colors.green[900],
                            borderRadius: BorderRadius.circular(5),
                            onTap: () => _dropdownProvider.dropDownValue == 'US'
                                ? _inputTextChangeNotifire.calculateSellingText(
                                    _dropdownProvider.dropDownValue == 'UG'
                                        ? data.ush
                                        : data.usd,
                                  )
                                : _inputTextChangeNotifire.calculateBuyingText(
                                    _dropdownProvider.dropDownValue == 'UG'
                                        ? data.ush
                                        : data.usd,
                                  ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: size.width * 0.4,
                              height: 60,
                              child: Text(
                                'CALCULATE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      error: (e, s) => Text('$e'),
                      loading: () => Text('Loading ...')),
            ],
          )
        ],
      ),
    );
  }
}
