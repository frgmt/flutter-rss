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