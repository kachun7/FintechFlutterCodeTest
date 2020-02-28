import 'package:code_test/presentation/store/bottom_bar_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class BottomBar extends StatefulWidget {
  final BottomBarStore bottomBarStore;

  const BottomBar({Key key, this.bottomBarStore}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Index 0: Loan',
        style: optionStyle,
      ),
    ),
    Center(
      child: Text(
        'Index 1: History',
        style: optionStyle,
      ),
    ),
  ];

  void _onItemTapped(int index) {
    widget.bottomBarStore.setPage(index == 0 ? Page.Loan : Page.History);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateBuilder<BottomBarStore>(
        models: [widget.bottomBarStore],
        builder: (context, builder) {
          switch (widget.bottomBarStore.currentPage) {
            case Page.Loan:
              return _widgetOptions[0];
            case Page.History:
              return _widgetOptions[1];
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesome5Solid.file_signature),
            title: Text('Loan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.history),
            title: Text('History'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
