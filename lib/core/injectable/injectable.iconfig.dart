// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:code_test/Repository/repository.dart';
import 'package:code_test/api/api.dart';
import 'package:code_test/presentation/store/bottom_bar_store.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<Repository>(() => Repository(
        g<API>(),
      ));
  g.registerFactory<BottomBarStore>(() => BottomBarStore());
}
