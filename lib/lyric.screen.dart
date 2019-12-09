import 'package:flutter/material.dart';
import 'model/song.dart';

class LyricScreen extends StatelessWidget {
  final Song song;
  LyricScreen({Key key, @required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          song.name,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(song.lyric, style: TextStyle(fontSize: 30.0)),
          )),
    );
  }
}

