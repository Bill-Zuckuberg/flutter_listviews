import 'dart:html';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo ListViews',
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Examble Listvews",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.red[100],
          ),
          body: Center(child: RamdomWords()),
        ));
  }
}

class RamdomWords extends StatefulWidget {
  @override
  RamdomWordsState createState() => RamdomWordsState();
}

class RamdomWordsState extends State<RamdomWords> {
  final wordPair = WordPair.random();
  final _words = <WordPair>[];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      if (index.isOdd) {
        return Divider();
      }
      if (index >= _words.length) {
        _words.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_words[index]);
    });
  }

  Widget _buildRow(WordPair wordPair) {
    return ListTile(
      title: Text(wordPair.asString,
          style: const TextStyle(
            fontSize: 18.0,
          )),
      trailing: Icon(
        Icons.favorite,
        color: Colors.red,
      ),
    );
  }
}
