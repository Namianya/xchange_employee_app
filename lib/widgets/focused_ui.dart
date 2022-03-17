import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../logic/dropdown_provider.dart';
import '../logic/riverpod_providers.dart';
import '../logic/text_input_change_notifire.dart';

class FocusedUI extends ConsumerWidget {
  const FocusedUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isByBuyingState = ref.watch(isBuyingChangeNotifier);
    final _dropdownProvider = ref.watch(dropDownChangeNotifire);
    final _inputTextChangeNotifire4 = ref.watch(inputTextChangeNotifire);
    var f = NumberFormat("#,###,###,##0.0#", "en_US");

    return Column(
      children: [
        Text(
          '${_inputTextChangeNotifire4.inputText ?? "Enter Amount in"}' +
              "  ${_isByBuyingState.isBuying ? _dropdownProvider.dropDownValue == 'US' ? 'USD' : 'USH' : 'KSH'}",
          style: Theme.of(context).textTheme.headline4?.copyWith(
                color: _inputTextChangeNotifire4.inputText != null
                    ? Colors.black
                    : Colors.grey,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${f.format(_inputTextChangeNotifire4.calculatedText)}',
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: _inputTextChangeNotifire4.inputText != "" ||
                            _inputTextChangeNotifire4.inputText != null
                        ? Colors.black
                        : Colors.grey,
                  ),
            ),
            const SizedBox(
              width: 15,
            ),
            _isByBuyingState.isBuying
                ? Text(
                    'KSH',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: _inputTextChangeNotifire4.inputText != "" ||
                                  _inputTextChangeNotifire4.inputText != null
                              ? Colors.black
                              : Colors.grey,
                        ),
                  )
                : Text(
                    _dropdownProvider.dropDownValue,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                          color: _inputTextChangeNotifire4.inputText != "" ||
                                  _inputTextChangeNotifire4.inputText != null
                              ? Colors.black
                              : Colors.grey,
                        ),
                  )
          ],
        ),
      ],
    );
  }
}
