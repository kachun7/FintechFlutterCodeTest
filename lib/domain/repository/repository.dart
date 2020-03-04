import 'package:code_test/core/injectable/injectable.dart';
import 'package:code_test/data/remote_datasource/api.dart';
import 'package:code_test/domain/models/application.dart';
import 'package:injectable/injectable.dart';
import 'package:retry/retry.dart';

abstract class Repository {
  ///
  /// Retrieves all previously submitted [Application].
  ///
  Future<List<Application>> fetchApplications();

  ///
  /// Submits a [application] to the api.
  ///
  Future<Application> submitApplication(Application application);
}

@Environment(Env.dev)
@RegisterAs(Repository)
@injectable
class RepositoryImpl extends Repository {
  static const kMaxAttempts = 3;
  static const kTimeoutDuration = Duration(seconds: 40);

  final API api;

  RepositoryImpl(this.api);

  @override
  Future<List<Application>> fetchApplications() {
    const RetryOptions retryOptions = RetryOptions(maxAttempts: kMaxAttempts);
    return retryOptions.retry(
      () => api.getApplications().timeout(kTimeoutDuration),
      retryIf: _shouldRetry,
    );
  }

  @override
  Future<Application> submitApplication(Application application) {
    const RetryOptions retryOptions = RetryOptions(maxAttempts: kMaxAttempts);
    return retryOptions.retry(
      () => api.submitApplication(application).timeout(kTimeoutDuration),
      retryIf: _shouldRetry,
    );
  }

  ///
  /// Should retry if [Exception] is [ApiTimeoutException]
  ///
  bool _shouldRetry(Exception e) => e is ApiTimeoutException;
}
