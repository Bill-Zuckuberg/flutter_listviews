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
      debugShowMaterialGrid: false,
      title: 'Demo ListViews',
      home: RamdomWords(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RamdomWords extends StatefulWidget {
  @override
  RamdomWordsState createState() => RamdomWordsState();
}

class RamdomWordsState extends State<RamdomWords> {
  final WordPair wordPair = WordPair.random();
  final List<WordPair> _words = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Examble Listvews",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red[100],
        actions: [
          IconButton(
              onPressed: _pushSaved,
              icon: const Icon(
                Icons.list,
                color: Colors.black,
              ))
        ],
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
    final bool alreadySaved = _saved.contains(wordPair);

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
            _saved.remove(wordPair);
          else
            _saved.add(wordPair);
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((e) => ListTile(
            title: Text(e.asString,
                style: const TextStyle(
                  fontSize: 18.0,
                )),
          ));
      final List<Widget> divided =
          ListTile.divideTiles(tiles: tiles, context: context).toList();
      return Scaffold(
        appBar: AppBar(
            title:
                const Text("Saved list", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.red[100],
            iconTheme: IconThemeData(color: Colors.black)),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }
}
