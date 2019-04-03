import 'package:flutter/material.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchRouteWidget();
  }
}

class _SearchRouteWidget extends State<SearchRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topCenter,
      child: Column(
        children: <Widget>[_buildWordArea(), _buildDescriptionArea()],
      ),
    );
  }

  Widget _buildWordArea() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Card(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter word for search",
                      border: OutlineInputBorder()),
                ),
              ),
              _buildWordButtonArea()
            ],
        ),
      ),
          )),
    );
  }

  Widget _buildWordButtonArea() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: RaisedButton(
              child: Text("SEND"),
              color: Colors.lightBlue,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
          RaisedButton(
            child: Icon(Icons.favorite, color: Colors.red),
            color: Colors.grey.shade200,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildDescriptionArea() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 0.0),
        child: Center(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return _buildListViewItem();
              }),
        ),
      ),
    );
  }

  Widget _buildListViewItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Long long description..."),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text("Example: example..."),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Text("Author name"),
                ))
          ],
        ),
      ),
    );
  }
}
