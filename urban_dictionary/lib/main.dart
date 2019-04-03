import 'package:flutter/material.dart';
import 'package:urban_dictionary/ui/SearchRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            appBar: AppBar(
              title: Text("Urban Dictionary"),
            ),
            body: SearchRoute(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 0,
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
                    icon: Icon(Icons.favorite), title: Text('Favorites'))
              ],
            )));
  }
}
