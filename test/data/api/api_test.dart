import 'package:code_test/data/remote_datasource/api.dart';
import 'package:code_test/domain/models/application.dart';
import 'package:test/test.dart';

void main() {
  group('Submit Application', () {
    final testApplication = Application(firstName: 'test', lastName: 'testsson', email: '194907011813', loanAmount: 500000);

    test('Submit should return successfullly with the application', () async {
      // Prepare
      const int errorChance = null; // Should not simulate an error
      const delay = 4;
      final repo = MockAPI.test(errorChance: errorChance, delay: delay);

      // Test
      final resp = await repo.submitApplication(testApplication);

      // Assert
      expect(resp, const TypeMatcher<Application>());
      expect(resp, testApplication);
    });

    test('Submit should throw an [ArgumentError] when submit is missing the argument application', () async {
      // Prepare
      const int errorChance = null; // Should not simulate an error
      const delay = 4;
      final repo = MockAPI.test(errorChance: errorChance, delay: delay);
      // Test & assert that an ArgumentError was thrown
      expect(repo.submitApplication(null), throwsArgumentError);
    });

    test('Submit should throw an [Exception] when submit fails to persist the application', () async {
      // Prepare
      const int errorChance = 1; // 1 in 1 chance of throwing an error
      const delay = 4;
      final repo = MockAPI.test(errorChance: errorChance, delay: delay);

      // Test & assert that an ApiTimeoutException was thrown
      expect(repo.submitApplication(testApplication), throwsException);
    });
  });

  group('Get Applications', () {
    test('Get should return successfullly with the applications', () async {
      // Prepare
      const int errorChance = null; // Should not simulate an error
      const delay = 4;
      final repo = MockAPI.test(errorChance: errorChance, delay: delay);

      // Test
      final resp = await repo.getApplications();

      // Assert
      expect(resp, const TypeMatcher<List<Application>>());
      expect(resp.length, 8);
    });

    test('Should throw an [Exception] when get fails to retrieve the applications', () async {
      // Prepare
      const errorChance = 1; // 1 in 1 chance of throwing an error
      const delay = 4;
      final repo = MockAPI.test(errorChance: errorChance, delay: delay);

      // Test & assert that an ApiTimeoutException was thrown
      expect(repo.getApplications(), throwsException);
    });
  });
}
