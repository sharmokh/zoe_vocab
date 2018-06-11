import 'package:flutter/material.dart';
import 'package:zoe_vocab/card_swipe.dart';
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

  Widget layoutCards(List<SingleCard> cards, int index) {
    print(index);
    if (index == 0) {
      return cards[0];
    } else {
      return Stack (
        children: [
          layoutCards(cards, index - 1),
          cards[index],
        ]
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cards = <SingleCard>[];
    for (var i = 0; i < _imagePaths.length; i++){
      cards.add(SingleCard(
        imagePath: _imagePaths[i],
        name: _names[i],
        offSet: (i + 1) * 20.0,
      ));
    }
    final index = cards.length - 1;

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
            layoutCards(cards, cards.length - 2),
            CardSwipe(
              swipeCard: cards[cards.length - 1]
            ),
          ],
        ),
      )
    );
  }
}


/* class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
