import 'package:flutter/material.dart';

class WordListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WordListWidgetState();
  }
}

class WordListWidgetState extends State<WordListWidget> {

  @override
  Widget build(BuildContext context) {
    return _buildWordList();
  }

  Widget _buildWordList() {
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
      padding: const EdgeInsets.only(
          top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildWordPart(),
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

  Widget _buildWordPart() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("WORD"),
          Divider(
            height: 4.0,
          )
        ],
      ),
    );
  }

}
