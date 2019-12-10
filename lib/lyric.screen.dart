import 'package:flutter/material.dart';
import 'model/song.dart';
import 'video.screen.dart';

class LyricScreen extends StatelessWidget {
  final Song song;
  LyricScreen({Key key, @required this.song}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song.name),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice) {
              print(choice);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoScreen(keyword: song.name, site: choice),
                ),
              );
            },
            itemBuilder: (BuildContext ctx) {
              return [
                PopupMenuItem<String>(
                  value: 'youtube',
                  child: Text('Youtube'),
                ),
                PopupMenuItem<String>(
                  value: 'qq',
                  child: Text('腾讯视频'),
                ),
                PopupMenuItem<String>(
                  value: 'iqiyi',
                  child: Text('爱奇艺'),
                ),
              ];
            },
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(song.lyric, style: TextStyle(fontSize: 30.0)),
          )),
    );
  }
}

