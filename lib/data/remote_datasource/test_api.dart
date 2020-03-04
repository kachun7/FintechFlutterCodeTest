import 'package:code_test/core/injectable/injectable.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'api.dart';

@Environment(Env.test)
@RegisterAs(API)
@injectable
class TestAPI extends Mock implements API {}
