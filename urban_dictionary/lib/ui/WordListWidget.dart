import 'package:flutter/material.dart';
import 'package:urban_dictionary/bloc/FavoritesBloc.dart';
import 'package:urban_dictionary/bloc/HistoryBloc.dart';
import 'package:urban_dictionary/bloc/WordInfoState.dart';
import 'package:urban_dictionary/entities/UrbanWordInfo.dart';
import 'package:urban_dictionary/ui/enums/RouteTag.dart';

class WordListWidget extends StatefulWidget {
  final RouteTag routeTag;

  WordListWidget(this.routeTag);

  @override
  State<StatefulWidget> createState() {
    return WordListWidgetState();
  }
}

class WordListWidgetState extends State<WordListWidget> {
  HistoryBloc _historyBloc;
  FavoritesBloc _favoritesBloc;

  @override
  Widget build(BuildContext context) {
    return _defineUrbanWordStream();
  }

  @override
  void initState() {
    if (widget.routeTag == RouteTag.HISTORY) {
      _historyBloc = HistoryBloc();
      _historyBloc.getHistoryWordInfo();
    } else {
      _favoritesBloc = FavoritesBloc();
      _favoritesBloc.getFavoritesWordInfo();
    }
    super.initState();
  }

  Widget _defineUrbanWordStream() {
    return StreamBuilder<WordInfoState>(
      stream: _historyBloc?.historyWordInfoStream ??
          _favoritesBloc.favoritesWordInfo,
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
        child: Text('Ooops...list is empty'),
      ),
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

  Widget _buildListViewItem(UrbanWordInfo wordInfo) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.only(
          top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildWordPart(wordInfo),
            Text(
              "Definition:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(wordInfo.description),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Example:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(wordInfo.example),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Text(wordInfo.author,
                      style: TextStyle(fontStyle: FontStyle.italic)),
                ))
          ],
        ),
      ),
    ));
  }

  Widget _buildWordPart(UrbanWordInfo wordInfo) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(wordInfo.word.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          Divider(
            height: 16.0,
            color: Colors.lightBlue,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
