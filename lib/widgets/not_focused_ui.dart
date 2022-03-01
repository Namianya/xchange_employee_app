import 'package:fare_rate_mm/logic/riverpod_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../logic/dropdown_provider.dart';
import '../logic/text_input_change_notifire.dart';

class NotFocusedUI extends ConsumerWidget {
  const NotFocusedUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isByBuyingState = ref.watch(isBuyingChangeNotifier);
    final _dropdownProvider = ref.watch(dropDownChangeNotifire);
    final _inputTextChangeNotifire = ref.watch(inputTextChangeNotifire);
    var f = NumberFormat("#,###,###,###.0#", "en_US");

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${f.format(_inputTextChangeNotifire.calculatedText)}',
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _inputTextChangeNotifire.inputText != ""
                        ? Colors.black
                        : Colors.grey,
                  ),
            ),
            const SizedBox(
              width: 15,
            ),
            _isByBuyingState.isBuying
                ? Text(
                    _dropdownProvider.dropDownValue == 'US' ? 'USD' : 'USH',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: _inputTextChangeNotifire.inputText != "" ||
                                  _inputTextChangeNotifire.inputText != null
                              ? Colors.black
                              : Colors.grey,
                        ),
                  )
                : Text(
                    'KSH',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: _inputTextChangeNotifire.inputText != "" ||
                                  _inputTextChangeNotifire.inputText != null
                              ? Colors.black
                              : Colors.grey,
                        ),
                  )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          '${_inputTextChangeNotifire.inputText?.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') ?? "Enter Amount"}',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                color: _inputTextChangeNotifire.inputText != null ||
                        _inputTextChangeNotifire.inputText != null
                    ? Colors.black
                    : Colors.grey,
              ),
        ),
      ],
    );
  }
}
