import 'number_formatter.dart';

class ValidatorUtility {
  static const String kNumberRegValue = '[^0-9]';
  static final RegExp kEmailRegExp =
      RegExp('[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+');
  static final RegExp kNumberRegExp = RegExp('[^0-9]');

  ///
  /// Check [value] is not empty and characters are no longer than [max].
  ///
  String validateString(String value, String text, int max) {
    if (value.isEmpty) {
      return 'Please enter $text.';
    }
    if (value.length > max) {
      return '$text cannot be longer than $max characters.';
    }
    return null;
  }

  ///
  /// Check if [value] has a valid email format.
  ///
  String validateEmail(String value, String text) {
    if (value.isEmpty) {
      return 'Please enter $text.';
    }
    if (kEmailRegExp.hasMatch(value)) {
      // The email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return '$text is not valid.';
  }

  ///
  /// Check [value] is within [min] and [max]
  ///
  String validateNumber(String value, String text, double min, double max) {
    if (value.isEmpty) {
      return 'Please enter $text.';
    }

    final String trimmedDigits = value.replaceAll(kNumberRegExp, '');
    final double trimmedValue = double.parse(trimmedDigits);
    if (trimmedValue < min) {
      return 'The mininum value is ${NumberFormatter.format(min)}.';
    }

    if (trimmedValue > max) {
      return 'The maximum value is ${NumberFormatter.format(max)}.';
    }
    return null;
  }
}
