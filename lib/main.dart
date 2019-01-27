import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoe_vocab/studyCards.dart';
import 'package:zoe_vocab/cards.dart';
import 'package:zoe_vocab/alphabetDialog.dart';
import 'package:zoe_vocab/syllableDialog.dart';
import 'package:zoe_vocab/infoDescription.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]);
    return MaterialApp(
      title: "Zoe's Words",
      home: SwipeCards(),
    );
  }
}

class SwipeCards extends StatefulWidget {
  @override
  _SwipeCardsState createState() => new _SwipeCardsState();
}

class _SwipeCardsState extends State<SwipeCards> {
  List<String> categories = ['animals', 'actions', 'outside'];
  List<String> chosenLetters = ['ALL'];
  List<String> chosenSyllables = ['Every Word'];
  List<String> chosenCategories = [];
  List<StudyCard> chosenCards = [];

  Widget _createButtons(String name) {
    bool buttonToggle;
    if (chosenCategories.contains(name))
      buttonToggle = true;
    else buttonToggle = false;
    return FlatButton(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 5.0,
            color: buttonToggle ? Colors.lightBlueAccent : Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5.0
            )
          ],
          image: DecorationImage(
            image: AssetImage('images/' + name + '.jpg'),
            fit: BoxFit.contain,
          ),
        )
      ),
      splashColor: Colors.grey,
      onPressed: () {
        setState(() {
          if (buttonToggle)
            chosenCategories.remove(name);
          else chosenCategories.add(name);
          buttonToggle = !buttonToggle;
        });
      },
    );
  }

  _chosenCards(){
    chosenCards = [];

    for (int i = 0; i < cards.length; i++) {
      if (chosenCategories.contains(cards[i].category)) {
        if (chosenLetters.contains('ALL')) {
          for (int j = 0; j < chosenSyllables.length; j++) {
            switch (chosenSyllables[j]) {
              case '(1) Monosyllable Words':
                if (cards[i].syllable == 1)
                  chosenCards.add(cards[i]);
                break;
              case '(2) Disyllables Words':
                if (cards[i].syllable == 2)
                  chosenCards.add(cards[i]);
                break;
              case 'Multisyllable Words':
                if (cards[i].syllable > 2)
                  chosenCards.add(cards[i]);
                break;
              default:
                chosenCards.add(cards[i]);
                break;
            }
          }
        } else {
          for (int k = 0; k < chosenLetters.length; k++) {
            if (cards[i].name[0].toUpperCase() == chosenLetters[k]) {
              for (int j = 0; j < chosenSyllables.length; j++) {
                switch (chosenSyllables[j]) {
                  case '(1) Monosyllable Words':
                    if (cards[i].syllable == 1)
                      chosenCards.add(cards[i]);
                    break;
                  case '(2) Disyllables Words':
                    if (cards[i].syllable == 2)
                      chosenCards.add(cards[i]);
                    break;
                  case 'Multisyllable Words':
                    if (cards[i].syllable > 2)
                      chosenCards.add(cards[i]);
                    break;
                  default:
                    chosenCards.add(cards[i]);
                    break;
                }
              }
            }
          }
        }
      }
    };
    chosenCards.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    bool toggleForward = false;
    if (chosenCategories.length != 0) {toggleForward = true;}

    return MaterialApp(
      title: "Zoe's Words",
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Choose Categories'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              tooltip: 'Info',
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                    children: [
                      InfoDescription(
                        description: 'Select one or more catgories.',
                        iconName: Icons.grid_on,
                      ),
                      InfoDescription(
                        description: 'Select ALL words or words that start with certain letters.',
                        iconName: Icons.font_download,
                      ),
                      InfoDescription(
                        description: 'Select monosyllable, disyllable, multisyllable or every word.',
                        iconName: Icons.looks_one,
                      ),
                      InfoDescription(
                        description: 'Generates a set of cards after selecting one or more categories.',
                        iconName: Icons.forward,
                      )
                    ]
                  )
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.font_download),
              tooltip: 'Choose LETTERS to focus on',
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (_) => AlphabetDialog(
                    initialValue: chosenLetters,
                    onValueChange: _onLetterChange,
                  )
                );
              }
            ),
            IconButton(
              icon: Icon(Icons.looks_one),
              tooltip: 'Choose number of SYLLABLES',
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (_) => SyllableDialog(
                    initialValue: chosenSyllables,
                    onValueChange: _onSyllableChange,
                  )
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.forward),
              tooltip: 'Generate Study Cards',
              color: toggleForward ? Colors.white : Colors.grey,
              onPressed: toggleForward ? (){
                setState(() {
                  _chosenCards();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudyCards(cardDeck: chosenCards)),
                );
              } : (){},
            )
          ]
        ),
        body: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.all(6.0),
              child: _createButtons(categories[index]),
            );
          },
        )
      )
    );
  }

  void _onLetterChange(List<String> newOptions) {
    setState(() {
      chosenLetters = newOptions;
      if (chosenLetters.length == 0) {chosenLetters.add('ALL');}
    });
  }

  void _onSyllableChange(List<String> newOptions) {
    setState(() {
      chosenSyllables = newOptions;
      if (chosenSyllables.length == 0) {chosenSyllables.add('Every Word');}
    });
  }

}