import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:azlistview/azlistview.dart';
import 'model/song.dart';
import 'lyric.screen.dart';

Future<List<Song>> loadSongs() async {
  String jsonString = await rootBundle.loadString('assets/song-sorted.json');
  final jsonResponse = json.decode(jsonString) as List;
  return jsonResponse.map<Song>((s) => Song.fromJson(s)).toList();
}

class SongList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SongListState();
  }
}

class _SongListState extends State<SongList> {
  List<Song> _songs;
  bool _loading = true;
  String _suspensionTag = '';
  int _suspensionHeight = 40;
  int _itemHeight = 50;

  @override
  void initState() {
    super.initState();
    loadSongs().then((s) {
      SuspensionUtil.sortListBySuspensionTag(_songs);
      setState(() {
        _songs = s;
        _loading = false;
      });
    });
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  Widget _buildSusWidget(String susTag) {
    // susTag = (susTag == "★" ? "热门城市" : susTag);
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  Widget _buildListItem(Song model) {
    String susTag = model.getSuspensionTag();
    return _loading
        ? Center(
            child: new CircularProgressIndicator(),
          )
        : Column(
            children: <Widget>[
              Offstage(
                offstage: model.isShowSuspension != true,
                child: _buildSusWidget(susTag),
              ),
              SizedBox(
                height: _itemHeight.toDouble(),
                child: ListTile(
                  title: Text(model.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LyricScreen(song: model),
                      ),
                    );
                  },
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: AzListView(
              data: _songs,
              // topData: _hotCityList,
              itemBuilder: (context, model) => _buildListItem(model),
              suspensionWidget: _buildSusWidget(_suspensionTag),
              isUseRealIndex: true,
              itemHeight: _itemHeight,
              suspensionHeight: _suspensionHeight,
              onSusTagChanged: _onSusTagChanged,
              //showCenterTip: false,
            )),
      ],
    );
  }
}
