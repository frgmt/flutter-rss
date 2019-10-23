import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';
import './detail.dart';

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