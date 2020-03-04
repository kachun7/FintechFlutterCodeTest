import 'package:flutter/services.dart';

import 'number_formatter.dart';

class NumberInputFormatter extends TextInputFormatter {
  /// Allow the max number of digits.
  final int maxDigits;

  NumberInputFormatter(this.maxDigits);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Return the old value if the number of digits is larger than [maxDigits]
    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    // Format the number value into more human readable
    // For example 10000 will become 10 000
    final double value = double.parse(newValue.text);
    final String formattedValue = NumberFormatter.format(value);
    return newValue.copyWith(text: formattedValue, selection: TextSelection.collapsed(offset: formattedValue.length));
  }
}
