import 'package:flutter/material.dart';
import 'package:zoe_vocab/card_deck.dart';
import 'package:zoe_vocab/cards.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Cards',
      home: SwipeCards(),
    );
  }
}

class SwipeCards extends StatefulWidget {
  @override
  _SwipeCardsState createState() => new _SwipeCardsState();
}

class _SwipeCardsState extends State<SwipeCards> {

  static const _imagePaths = <String>[
    'http://pngimg.com/uploads/apple/apple_PNG12458.png',
    'http://www.freepngimg.com/download/banana/8-banana-png-image.png',
    'https://purepng.com/public/uploads/large/515023046579hvzohbmnlxqbdyqs1460y3msjygqbzq450jwkjlptpcrykihbss3ghbemg2ezgowfepfgdhheo0rziqr1ogu7qacx3zdqxltsnc.png',
    'http://www.freepngimg.com/download/dog/8-dog-png-image-picture-download-dogs.png',
  ];

  static const _names = <String>[
    'Apple',
    'Banana',
    'Cat',
    'Dog',
  ];

  @override
  Widget build(BuildContext context) {
    final cards = <SingleCard>[];
    for (var i = 0; i < _imagePaths.length; i++){
      cards.add(SingleCard(
        imagePath: _imagePaths[i],
        name: _names[i],
      ));
    }
    cards.shuffle();

    return MaterialApp(
      title: 'Flashcards',
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Flash Cards'),
        ),
        body: Stack(
          children: [
            Container(
              child: Center(
                child: Text(
                  'All Done!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            CardDeck(
              cardDeck: cards
            ),
          ]
        )
      )
    );
  }
}
