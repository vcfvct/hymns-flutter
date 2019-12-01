import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lpinyin/lpinyin.dart';

class Song {
  String name;
  String lyric;

  Song({this.name, this.lyric});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(name: json['name'], lyric: json['lyric']);
  }
}

Future<List<Song>> loadSongs() async {
  String jsonString = await rootBundle.loadString('assets/song.json');
  final jsonResponse = json.decode(jsonString) as List;
  return jsonResponse.map<Song>((s) => Song.fromJson(s)).toList();
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hymns',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '敬拜赞美诗'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Song> _songs;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadSongs().then((s) => setState(() {
          _songs = s;
          _loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _loading
        ? Center(
            child: new CircularProgressIndicator(),
          )
        : Center(
            child: ListView.separated(
              itemCount: _songs.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ListTile(
                    title: Text(_songs[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LyricScreen(song: _songs[index]),
                        ),
                      );
                    },
                  );
              },
              separatorBuilder: (BuildContext ctx, int index) => const Divider(),
            ),
          ),
    );
  }
}

class LyricScreen extends StatelessWidget {
  final Song song;
  LyricScreen({Key key, @required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'song.name ${PinyinHelper.getShortPinyin(song.name)}',
          ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            song.lyric,
            style: TextStyle(fontSize: 30.0) 
          ),
        )
      ),
    );
  }
}
