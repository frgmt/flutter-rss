import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './list.dart';
import './models/rss.dart';

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

 class RssListPage extends StatefulWidget {
  RssListPage({Key key}) : super(key: key);

  @override
  _RssListPageState createState() => _RssListPageState();
}

class _RssListPageState extends State<RssListPage> {
  Future<List<Rss>> _rssList;

  @override
  void initState() {
    super.initState();
    _rssList = _fetchRssList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Yahoo RSS'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _rssList,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data != null ? snapshot.data.length : 0,
              itemBuilder: (context, index) {
                Rss rss = snapshot.data[index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: Text(rss.name, style: TextStyle(fontSize: 24.0),),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => RssPage(title: rss.name, url: rss.url)));
                      }
                    )
                  ],
                );
              }
            );
          }
        ),
      )
    );
  }

  Future<List<Rss>> _fetchRssList() async {
    var url = "https://fragment-datafiles.s3-ap-northeast-1.amazonaws.com/test/rss.json";
    final response = await http.get(url,
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Rss>((json) => Rss.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}