import 'package:code_test/core/injectable/injectable.dart';
import 'package:code_test/presentation/store/bottom_bar_store.dart';
import 'package:code_test/presentation/page/bottom_bar.dart';
import 'package:flutter/material.dart';

void main() {
  configure();
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
      home: BottomBar(
        bottomBarStore: getIt<BottomBarStore>(),
      ),
    );
  }
}
