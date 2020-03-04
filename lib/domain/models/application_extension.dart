import 'package:code_test/core/number_formatter.dart';

import 'application.dart';

/// Application helper functions
extension AppExtension on Application {

  // Combine [firstName] and [lastName]
  String get name => '$firstName $lastName';

  // Format loan amount
  String get loan => '${NumberFormatter.format(loanAmount)}';
}
