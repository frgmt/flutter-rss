import 'package:flutter/material.dart';
import './list.dart';

void main() => runApp(RssApp());

class RssApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.green
      ),
      home: new RssListPage(),
    );
  }
}

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