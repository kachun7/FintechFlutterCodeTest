// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:code_test/presentation/page/history_page.dart';
import 'package:code_test/presentation/store/loan_forrm_store.dart';
import 'package:code_test/data/remote_datasource/test_api.dart';
import 'package:code_test/data/remote_datasource/api.dart';
import 'package:code_test/domain/repository/mock_repository.dart';
import 'package:code_test/domain/repository/repository.dart';
import 'package:code_test/presentation/store/history_store.dart';
import 'package:code_test/presentation/store/loan_api_store.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<HistoryPage>(() => HistoryPage());
  g.registerFactory<LoanFormStore>(() => LoanFormStore());
  g.registerFactory<HistoryStore>(() => HistoryStore(
        g<Repository>(),
      ));
  g.registerFactory<LoanApiStore>(() => LoanApiStore(
        g<Repository>(),
      ));

  //Register test Dependencies --------
  if (environment == 'test') {
    g.registerFactory<API>(() => TestAPI());
    g.registerFactory<Repository>(() => MockRepository());
  }

  //Register dev Dependencies --------
  if (environment == 'dev') {
    g.registerLazySingleton<API>(() => MockAPI());
    g.registerFactory<Repository>(() => RepositoryImpl(
          g<API>(),
        ));
  }
}
