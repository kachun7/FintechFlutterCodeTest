import 'package:code_test/presentation/store/bottom_bar_store.dart';
import 'package:code_test/presentation/view/bottom_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  BottomBarStore _bottomBarStore = BottomBarStore();

  // This widget is the root of your application.
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
        bottomBarStore: _bottomBarStore,
      ),
      // home: Scaffold(
      //   body: Container(
      //     child: Center(
      //       child: Text(
      //         "Start",
      //         style: Theme.of(context).textTheme.display2,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
