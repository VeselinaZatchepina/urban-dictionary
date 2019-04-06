import 'package:flutter/material.dart';
import 'package:urban_dictionary/ui/enums/RouteTag.dart';
import 'package:urban_dictionary/ui/WordListWidget.dart';

class FavoritesRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoritesRouteState();
  }
}

class FavoritesRouteState extends State<FavoritesRoute> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        WordListWidget(RouteTag.FAVORITES)
      ],
    );
  }
}
