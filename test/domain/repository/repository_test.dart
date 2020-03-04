import 'package:code_test/core/injectable/injectable.dart';
import 'package:code_test/data/remote_datasource/api.dart';
import 'package:code_test/domain/models/application.dart';
import 'package:code_test/domain/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

void main() {
  setUpAll(() {
    configure(Env.test);
  });

  group('Submit Application', () {
    final testApplication = Application(firstName: 'test', lastName: 'testsson', email: '194907011813', loanAmount: 500000);

    test('Submit should return successfullly with the application', () async {
      // Prepare
      final Repository repository = getIt<Repository>();
      when(repository.submitApplication(testApplication)).thenAnswer((_) async => testApplication);

      // Test
      final resp = await repository.submitApplication(testApplication);

      // Assert
      expect(resp, const TypeMatcher<Application>());
      expect(resp, testApplication);
    });

    test('Submit should throw an [ArgumentError] when submit is missing the argument application', () async {
      final Repository repository = getIt<Repository>();
      when(repository.submitApplication(null)).thenThrow(ArgumentError('application is null'));

      // Test & assert that an ArgumentError was thrown
      expect(() => repository.submitApplication(null), throwsArgumentError);
      expect(() => repository.submitApplication(null), throwsA(const TypeMatcher<ArgumentError>()));
      verify(repository.submitApplication(null));
    });

    test('Submit should throw an [Exception] when submit fails to persist the application', () async {
      // Prepare
      final Repository repository = getIt<Repository>();
      when(repository.submitApplication(testApplication))
          .thenThrow(ApiTimeoutException('A timeout occurred during while retrieving the applications'));

      // Test & assert that an ApiTimeoutException was thrown
      expect(() => repository.submitApplication(testApplication), throwsException);
      expect(() => repository.submitApplication(testApplication), throwsA(const TypeMatcher<ApiTimeoutException>()));
      verify(repository.submitApplication(testApplication));
    });
  });

  group('Get Applications', () {
    final testApplication = Application(firstName: 'test', lastName: 'testsson', email: '194907011813', loanAmount: 500000);

    test('Get should return successfullly with the applications', () async {
      // Prepare
      final Repository repository = getIt<Repository>();
      when(repository.fetchApplications()).thenAnswer((_) async => [testApplication]);

      // Test
      final resp = await repository.fetchApplications();

      // Assert
      expect(resp, const TypeMatcher<List<Application>>());
      expect(resp.length, 1);
      verify(repository.fetchApplications());
    });

    test('Should throw an [Exception] when get fails to retrieve the applications', () async {
      // Prepare
      final Repository repository = getIt<Repository>();
      when(repository.fetchApplications())
          .thenThrow(ApiTimeoutException('A timeout occurred during while retrieving the applications'));

      // Test & assert that an ApiTimeoutException was thrown
      expect(() => repository.fetchApplications(), throwsException);
      expect(() => repository.fetchApplications(), throwsA(const TypeMatcher<ApiTimeoutException>()));
      verify(repository.fetchApplications());
    });
  });
}
