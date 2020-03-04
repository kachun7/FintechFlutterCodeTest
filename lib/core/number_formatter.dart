import 'package:intl/intl.dart';

class NumberFormatter {
  static const String kLocale = 'sv_SE';
  static const String kSpace = '\xA0';

  ///
  /// Format value into more human readable string
  ///
  /// For example 200000 value will become 200 000.
  ///
  static String format(double value) {
    final NumberFormat formatter = NumberFormat.currency(locale: kLocale, symbol: '', decimalDigits: 0);
    return formatter.format(value).trim().replaceAll(kSpace, ' ');
  }
}
