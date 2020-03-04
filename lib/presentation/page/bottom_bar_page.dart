import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class BottomBarPage extends StatefulWidget {
  final List<Widget> pages;

  const BottomBarPage(this.pages, {Key key}) : super(key: key);

  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _setPage,
        children: widget.pages,
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(FontAwesome5Solid.file_signature), title: Text('Loan')),
        BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.history), title: Text('History')),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).textSelectionHandleColor,
      onTap: _setPage,
    );
  }

  void _setPage(int index) {
    _pageController.jumpToPage(index);

    setState(() {
      _selectedIndex = index;
    });
  }
}
