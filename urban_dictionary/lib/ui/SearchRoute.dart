import 'package:flutter/material.dart';
import 'package:urban_dictionary/bloc/SearchBloc.dart';
import 'package:urban_dictionary/entities/UrbanWordInfo.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchRouteWidget();
  }
}

class _SearchRouteWidget extends State<SearchRoute> {
  SearchBloc _searchBloc;
  final textFieldController = TextEditingController();

  @override
  void initState() {
    _searchBloc = SearchBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topCenter,
      child: Column(
        children: <Widget>[_buildWordArea(), _defineUrbanWordStream()],
      ),
    );
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
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
                    padding:
                    const EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Enter word for search",
                          border: OutlineInputBorder()),
                          controller: textFieldController,
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
              onPressed: () {
                _searchBloc.getWordInfo(textFieldController.text);
              },
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

  Widget _defineUrbanWordStream() {
    return StreamBuilder<List<UrbanWordInfo>>(
      stream: _searchBloc.urbanWordInfo,
      initialData: List(),
      builder: (context, snapshot) {
        if (snapshot.data.isNotEmpty) {
          List<UrbanWordInfo> state = snapshot.data;
          return _buildDescriptionArea(state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildDescriptionArea(List<UrbanWordInfo> urbanWordInfos) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 0.0),
        child: Center(
          child: ListView.builder(
              itemCount: urbanWordInfos.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildListViewItem(urbanWordInfos[index]);
              }),
        ),
      ),
    );
  }

  Widget _buildListViewItem(UrbanWordInfo urbanWordInfo) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(urbanWordInfo.description),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(urbanWordInfo.example),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Text(urbanWordInfo.author),
                ))
          ],
        ),
      ),
    );
  }
}
