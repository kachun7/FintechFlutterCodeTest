import 'package:code_test/core/injectable/injectable.dart';
import 'package:code_test/data/remote_datasource/api.dart';
import 'package:code_test/domain/models/application.dart';
import 'package:code_test/domain/repository/repository.dart';
import 'package:code_test/presentation/store/history_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

void main() {
  setUpAll(() {
    configure(Env.test);
  });
  group('History Store', () {
    final testApplication = Application(firstName: 'test', lastName: 'testsson', email: '194907011813', loanAmount: 500000);
    test('Get should return successfully with applications', () async {
      // Prepare
      final Repository repository = getIt<Repository>();
      final HistoryStore historyStore = HistoryStore(repository);

      when(repository.fetchApplications()).thenAnswer((_) async => [testApplication]);

      // Test
      await historyStore.fetchHistory();

      // Assert
      expect(historyStore.applications, const TypeMatcher<List<Application>>());
      verify(historyStore.fetchHistory());
    });

    test('Should throw [Exception] when gets fails to retreive applications', () async {
      // Prepare
      final HistoryStore historyStore = HistoryStore(getIt<Repository>());

      when(historyStore.fetchHistory())
          .thenThrow(ApiTimeoutException('A timeout occurred during while retrieving the applications'));

      // Test & Assert
      expect(() => historyStore.fetchHistory(), throwsException);
      expect(() => historyStore.fetchHistory(), throwsA(const TypeMatcher<ApiTimeoutException>()));
      verify(historyStore.fetchHistory());
    });
  });
}
