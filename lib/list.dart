import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';
import './detail.dart';

 class RssListPage extends StatelessWidget {
  final List<String> names = [
    'ニュース',
    '国際情勢',
  ];

  final List<String> urls = [
    'https://news.yahoo.co.jp/pickup/rss.xml',
    'https://news.yahoo.co.jp/pickup/world/rss.xml'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yahoo RSS'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: items(context),
        ),
      )
    );
  }

  List<Widget> items(BuildContext context) {
    List<Widget> items = [];
    for (var i = 0; i < names.length; i++) {
      items.add(
        ListTile(
          contentPadding: EdgeInsets.all(10.0),
          title: Text(names[i], style: TextStyle(fontSize: 24.0),),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => RssPage(title: names[i], url: urls[i])));
          }
        )
      );
    }
    return items;
  }
}



class RssPage extends StatefulWidget {
  final String title;
  final String url;

  RssPage({@required this.title, @required this.url});

  @override
  _RssPageState createState() => new _RssPageState(title:title, url:url);
}

class _RssPageState extends State<RssPage> {
  final String title;
  final String url;
  List<Widget> _items = <Widget>[];

  _RssPageState({
    @required this.title,
    @required this.url
  }) { getItems(); }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: _items,
        ),
      )
    );
  }

  void getItems() async {
    List<Widget> list = <Widget>[];
    Response res = await get(url);
    RssFeed feed = new RssFeed.parse(res.body);
    for (RssItem item in feed.items) {
      list.add(ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: Text(
          item.title,
          style: TextStyle(fontSize: 24.0)
        ),
        subtitle: Text(
          item.pubDate
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(_) => ItemDetailPage(
                item: item, title: title, url: url
              ), 
            ),
          );
        },
      ));
    }
    setState(() {
      _items = list;
    });
  }
}