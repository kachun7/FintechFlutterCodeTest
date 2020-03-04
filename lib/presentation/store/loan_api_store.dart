import 'package:code_test/domain/models/application.dart';
import 'package:code_test/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoanApiStore {
  final Repository repository;

  LoanApiStore(this.repository);

  Future<void> submitApplication(Application application) async {
    await repository.submitApplication(application);
  }
}
