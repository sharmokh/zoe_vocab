import 'package:flutter/material.dart';
import 'package:zoe_vocab/cards.dart';
import 'package:zoe_vocab/cardDeck.dart';
import 'package:zoe_vocab/infoDescription.dart';

class StudyCards extends StatefulWidget {
  final List<StudyCard> cardDeck;

  const StudyCards({
    Key key,
    @required this.cardDeck,
  })  : assert(cardDeck != null),
        super(key: key);

  @override
  _StudyCardsState createState() => new _StudyCardsState();
}

class _StudyCardsState extends State<StudyCards> {
  final studyCards = <StudyCard>[];
  bool initialize = true;
  double offSetValue;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text('Study Cards'),
      actions: <Widget> [
        IconButton(
          icon: Icon(Icons.info),
          tooltip: 'Info',
          onPressed: (){
            showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                children: [
                  InfoDescription(
                    description: 'Touch the card to hear the word.',
                    iconName: Icons.touch_app,
                  ),
                  InfoDescription(
                    description: 'Swipe left if you mastered the card.',
                    iconName: Icons.chevron_left,
                  ),
                  InfoDescription(
                    description: 'Swipe right if you want to review it.',
                    iconName: Icons.chevron_right,
                  ),
                ]
              )
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.grid_on),
          tooltip: 'Return to Categories',
          onPressed: (){
            Navigator.pop(
                context
            );
          },
        )
      ],
    );
    if (initialize) {
      for (int i = 0; i < widget.cardDeck.length; i++)
        studyCards.add(widget.cardDeck[i]);
      initialize = false;
      double heightOfCard = MediaQuery.of(context).size.width - 24.0;
      int numberOfCards = studyCards.length + 3;
      double heightOfAppBar = appBar.preferredSize.height;
      offSetValue = (MediaQuery.of(context).size.height - heightOfCard - heightOfAppBar) / numberOfCards;
    }
    return MaterialApp(
        title: 'Study Cards',
        home: Scaffold(
            backgroundColor: Colors.black,
            appBar: appBar,
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
                  cardDeck: studyCards,
                  offSet: offSetValue,
                )
              ],
            )
        )
    );
  }

}