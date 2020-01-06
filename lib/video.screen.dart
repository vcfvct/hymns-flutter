import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoScreen extends StatelessWidget {
  final String keyword;
  final String site;
  VideoScreen({Key key, @required this.keyword, @required this.site})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$keyword - 视频'),
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              initialUrl: buildSearchUrl(),
              javascriptMode: JavascriptMode.unrestricted,
              // onPageFinished: (finish) => _isLoadingPage = false,
            ),
          ],
        ));
  }

  String buildSearchUrl() {
    String encodedKeyword = Uri.encodeComponent(keyword);
    switch (site) {
      case 'qq':
        return 'https://v.qq.com/x/search/?q=$encodedKeyword';
      case 'youtube':
        return 'https://www.youtube.com/results?q=$encodedKeyword';
      case 'iqiyi':
        return 'https://so.iqiyi.com/so/q_$encodedKeyword';
      default:
        throw new Exception('Unknown site $site');
    }
  }
}
