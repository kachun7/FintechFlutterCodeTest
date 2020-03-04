import 'package:code_test/core/injectable/injectable.dart';
import 'package:code_test/data/remote_datasource/api.dart';
import 'package:code_test/domain/models/application.dart';
import 'package:code_test/domain/repository/repository.dart';
import 'package:code_test/presentation/store/loan_api_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

void main() {
  setUpAll(() {
    configure(Env.test);
  });
  group('Loan API Store', () {
    final testApplication = Application(firstName: 'test', lastName: 'testsson', email: '194907011813', loanAmount: 500000);
    test('Get should return successfully with application', () async {
      // Prepare
      final LoanApiStore store = LoanApiStore(getIt<Repository>());

      when(store.submitApplication(testApplication)).thenAnswer((_) async => [testApplication]);

      // Test & Assert
      expect(() => store.submitApplication(testApplication), throwsA(const TypeMatcher<void>()));
      verify(store.submitApplication(testApplication));
    });

    test('Should throw [Exception] when submit fails to persist the application', () async {
      // Prepare
      final LoanApiStore store = LoanApiStore(getIt<Repository>());

      when(store.submitApplication(testApplication))
          .thenThrow(ApiTimeoutException('A timeout occurred during while retrieving the applications'));

      // Test & Assert
      expect(() => store.submitApplication(testApplication), throwsException);
      expect(() => store.submitApplication(testApplication), throwsA(const TypeMatcher<ApiTimeoutException>()));
      verify(store.submitApplication(testApplication));
    });
  });
}
