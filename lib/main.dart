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
    return MaterialApp(title: 'Demo ListViews', home: RamdomWords());
  }
}

class RamdomWords extends StatefulWidget {
  @override
  RamdomWordsState createState() => RamdomWordsState();
}

class RamdomWordsState extends State<RamdomWords> {
  final wordPair = WordPair.random();
  final _words = <WordPair>[];
  final Set<WordPair> _save = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Examble Listvews",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red[100],
        actions: [IconButton(onPressed: null, icon: Icon(Icons.list))],
      ),
      body: Center(child: ListView.builder(itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        }
        if (index >= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_words[index]);
      })),
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final bool alreadySaved = _save.contains(wordPair);

    return ListTile(
      title: Text(wordPair.asString,
          style: const TextStyle(
            fontSize: 18.0,
          )),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved)
            _save.remove(wordPair);
          else
            _save.add(wordPair);
        });
      },
    );
  }
}
