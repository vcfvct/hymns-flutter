import 'dart:convert';
import 'dart:io';
import 'package:lpinyin/lpinyin.dart';

void main() {
  String jsonString = new File('./assets/song.json').readAsStringSync();
  final jsonResponse = json.decode(jsonString) as List;
  print(jsonResponse.length);
  jsonResponse.forEach((j) {
    String name = j['name'];
    String pinyin = PinyinHelper.getPinyinE(name);
    String tag = pinyin.substring(0, 1).toUpperCase();
    j['namePinyin'] = pinyin;
    String shortPinyin = '';
    try {
      shortPinyin = PinyinHelper.getShortPinyin(
          name.replaceAll(',', '').replaceAll('-', ''));
    } catch (e) {
      print(name);
      print(e);
    }
    j['shortPinyin'] = shortPinyin;

    j['tagIndex'] = RegExp("[A-Z]").hasMatch(tag) ? tag : '#';
  });
  jsonResponse.sort((s1, s2) => s1['shortPinyin'].compareTo(s2['shortPinyin']));

  new File('./assets/song-sorted.json').writeAsString(json.encode(jsonResponse));

}
