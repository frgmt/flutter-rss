import 'package:flutter/material.dart';

class Rss {
  final String name;
  final String url;

  Rss({
    this.name,
    this.url
  });

  factory Rss.fromJson(Map<String, dynamic> json) {
    return Rss(
      name: json['name'],
      url: json['url'],
    );
  }
}