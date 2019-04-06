import 'package:flutter/material.dart';
import 'package:urban_dictionary/ui/FavoritesRoute.dart';
import 'package:urban_dictionary/ui/HistoryRoute.dart';
import 'package:urban_dictionary/ui/SearchRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Urban Dictionary', home: RootWidget());
  }
}

class RootWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RootWidgetState();
  }
}

class RootWidgetState extends State<RootWidget> {
  List<Widget> _pages;
  Widget _selectedContent;
  int _bottomIndex;

  @override
  void initState() {
    _bottomIndex = 0;
    _definePages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Urban Dictionary"),
        ),
        body: _selectedContent ?? _pages[_bottomIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomIndex,
          onTap: (int index) {
            _onTabTapped(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: new Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: new Text('History'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favorites'))
          ],
        ));
  }

  void _definePages() {
    _pages = [
      SearchRoute(),
      HistoryRoute(),
      FavoritesRoute(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _bottomIndex = index;
      _selectedContent = _pages[index];
    });
  }
}
