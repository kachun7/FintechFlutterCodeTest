import 'package:code_test/core/injectable/injectable.dart';
import 'package:code_test/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';

@Environment(Env.test)
@RegisterAs(Repository)
@injectable
class MockRepository extends Mock implements Repository {}
