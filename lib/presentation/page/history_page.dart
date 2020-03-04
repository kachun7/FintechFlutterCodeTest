import 'package:code_test/domain/models/application.dart';
import 'package:code_test/domain/models/application_extension.dart';
import 'package:code_test/presentation/store/history_store.dart';
import 'package:code_test/presentation/view/error_message.dart';
import 'package:code_test/presentation/view/loading_indicator.dart';
import 'package:code_test/presentation/view/refresh_view.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

@injectable
class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submitted Applications'),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return WhenRebuilder<HistoryStore>(
      initState: (_, store) => _fetchHistory(),
      models: [ReactiveModel<HistoryStore>()],
      onIdle: () => _getListView([]),
      onWaiting: () => LoadingIndicator(),
      onError: (error) => ErrorMessage(error, _fetchHistory),
      onData: (data) => _getListView(data.applications),
    );
  }

  Widget _getListView(List<Application> items) {
    return RefreshView(
      onRefresh: _fetchHistory,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => _getListTile(items[index]),
      ),
    );
  }

  Widget _getListTile(Application application) {
    return ListTile(
      title: Text(application.name),
      subtitle: Text(application.email),
      trailing: Text(application.loan),
    );
  }

  void _fetchHistory() {
    final ReactiveModel<HistoryStore> historyService = ReactiveModel<HistoryStore>();
    historyService.setState((store) => store.fetchHistory());
  }
}
