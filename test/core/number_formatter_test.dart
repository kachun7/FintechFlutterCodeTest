import 'package:code_test/core/number_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Number formatter', () {
    test('Formatter should return formatted number', () async {
      // Prepare
      final formattedValue = NumberFormatter.format(20000);

      // Test & Assert
      expect(formattedValue, '20 000');
    });

    test('Formatter should return formatted number', () async {
      // Prepare
      final formattedValue = NumberFormatter.format(2000);

      // Test & Assert
      expect(formattedValue, '2 000');
    });

    test('Formatter should return formatted number', () async {
      // Prepare
      final formattedValue = NumberFormatter.format(200);

      // Test & Assert
      expect(formattedValue, '200');
    });
  });
}
