import 'package:azlistview/azlistview.dart';

class Song extends ISuspensionBean {
  String name;
  String lyric;
  String tagIndex;
  String namePinyin;
  String shortPinyin;

  Song({this.name, this.lyric});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(name: json['name'], lyric: json['lyric']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'lyric': lyric,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        // 'isShowSuspension': isShowSuspension,
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => 'SongBean { "name":"$name" }';
}

