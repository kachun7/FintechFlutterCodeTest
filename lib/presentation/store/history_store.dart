import 'dart:async';

import 'package:code_test/domain/models/application.dart';
import 'package:code_test/domain/repository/repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class HistoryStore {
  final Repository repository;

  List<Application> _applications = [];

  HistoryStore(this.repository);

  List<Application> get applications => _applications;

  Future<void> fetchHistory() async {
    _applications = await repository.fetchApplications();
  }
}
