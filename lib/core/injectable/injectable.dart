import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.iconfig.dart';

abstract class Env {
  static const String dev = 'dev';
  static const String test = 'test';
}

final GetIt getIt = GetIt.instance;

@injectableInit
void configure(String environment) => $initGetIt(getIt, environment: environment);
