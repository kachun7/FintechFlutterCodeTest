import 'package:code_test/core/injectable/injectable.dart';
import 'package:code_test/presentation/page/history_page.dart';
import 'package:code_test/presentation/page/bottom_bar_page.dart';
import 'package:code_test/presentation/page/loan_page.dart';
import 'package:code_test/presentation/store/history_store.dart';
import 'package:code_test/presentation/store/loan_api_store.dart';
import 'package:code_test/presentation/store/loan_forrm_store.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() {
  configure(Env.dev);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fintech Code challenge',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BottomBarPage(_getBottomBarWidgets()),
    );
  }

  List<Widget> _getBottomBarWidgets() {
    return <Widget>[
      Injector(
        inject: [
          Inject(() => getIt<LoanApiStore>()),
          Inject(() => getIt<LoanFormStore>()),
        ],
        builder: (_) => LoanPage(),
      ),
      Injector(
        inject: [
          Inject(() => getIt<HistoryStore>()),
        ],
        builder: (_) => HistoryPage(),
      ),
    ];
  }
}
