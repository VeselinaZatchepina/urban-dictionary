import 'package:flutter/material.dart';
import 'package:urban_dictionary/ui/WordListWidget.dart';

class HistoryRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryRouteState();
  }
}

class _HistoryRouteState extends State<HistoryRoute> {
  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical,
        children: <Widget>[
        WordListWidget()
      ],
    );
  }

}