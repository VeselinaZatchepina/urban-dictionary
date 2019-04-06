import 'package:flutter/material.dart';
import 'package:urban_dictionary/bloc/SearchBloc.dart';
import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/entities/UrbanWordInfo.dart';

class SearchRoute extends StatefulWidget {
  String wordForSearch;

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
    if (widget.wordForSearch != null && widget.wordForSearch.isNotEmpty) {
      setState(() {
        textFieldController.text = widget.wordForSearch;
        _searchBloc.getWordInfo(widget.wordForSearch, false);
      });
    }
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
                widget.wordForSearch = textFieldController.text;
                _searchBloc.getWordInfo(textFieldController.text, true);
              },
            ),
          ),
          _defineFavoritesButtonStream(),
        ],
      ),
    );
  }

  Widget _defineUrbanWordStream() {
    return StreamBuilder<WordInfoState>(
      stream: _searchBloc.searchWordInfo,
      initialData: WordInfoState.init(),
      builder: (context, snapshot) {
        if (snapshot.data is WordInfoInit) {
          return Container();
        }

        if (snapshot.data is WordInfoLoading) {
          return _buildLoading();
        }

        if (snapshot.data is WordInfoError) {
          return _buildError();
        }

        if (snapshot.data is WordInfoSuccess) {
          WordInfoSuccess wordInfoSuccess = snapshot.data;
          if (wordInfoSuccess.urbanWordInfos.isNotEmpty) {
            return _buildDescriptionArea(wordInfoSuccess.urbanWordInfos);
          } else {
            return _buildError();
          }
        }
      },
    );
  }

  Widget _defineFavoritesButtonStream() {
    return StreamBuilder<WordInfoState>(
      stream: _searchBloc.searchWordInfo,
      initialData: WordInfoState.init(),
      builder: (context, snapshot) {
        if (snapshot.data is WordInfoInit) {
          return createDisableBtn();
        }

        if (snapshot.data is WordInfoLoading) {
          return createDisableBtn();
        }

        if (snapshot.data is WordInfoError) {
          return createDisableBtn();
        }

        if (snapshot.data is WordInfoSuccess) {
          WordInfoSuccess wordInfoSuccess = snapshot.data;
          if (wordInfoSuccess.urbanWordInfos.isNotEmpty) {
            return createActiveBtn();
          } else {
            return createDisableBtn();
          }
        }
      },
    );
  }

  Widget createDisableBtn() {
    return RaisedButton(
        child: Icon(Icons.favorite, color: Colors.red),
        color: Colors.grey.shade200,
        disabledColor: Colors.grey.shade200,
        disabledElevation: 0.0,
        disabledTextColor: Colors.grey.shade200,
        onPressed: null);
  }

  Widget createActiveBtn() {
    return RaisedButton(
        child: Icon(Icons.favorite, color: Colors.red),
    color: Colors.grey.shade200,
    onPressed: () {
          _searchBloc.addWordInfoToFavorites();
          _searchBloc.addToFavoritesWordInfo.listen((id) {
            SnackBar snackBar;
            if (id != -1) {
              snackBar = SnackBar(content: Text('Yay! Word added to favorites!'));
            } else {
              snackBar = SnackBar(content: Text('Oops! Something went wrong...'));
            }
            Scaffold.of(context).showSnackBar(snackBar);
          });
    });
  }

  Widget _buildLoading() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError() {
    return Expanded(
      child: Center(
        child: Text('Ooops...we can\'t find such word'),
      ),
    );
  }

  Widget _buildDescriptionArea(List<UrbanWordInfo> urbanWordInfos) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 0.0),
        child: Center(
          child: ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(
                    color: Colors.lightBlue,
                  ),
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
            Text(
              "Definition:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(urbanWordInfo.description),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Example:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(urbanWordInfo.example),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Text(
                    urbanWordInfo.author,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
