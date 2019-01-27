import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zoe_vocab/cards.dart';
import 'package:zoe_vocab/renderCard.dart';
import 'package:tts/tts.dart';

class CardDeck extends StatefulWidget {
  final List<StudyCard> cardDeck;
  final double offSet;

  const CardDeck({
    Key key,
    @required this.cardDeck,
    @required this.offSet,
  })  : assert(cardDeck != null),
        assert(offSet != null),
        super(key: key);

  @override
  _CardDeckState createState() => new _CardDeckState();
}

class _CardDeckState extends State<CardDeck> with TickerProviderStateMixin {
  final reviewCards = <StudyCard>[];
  double _scrollPercent = 0.0;
  Offset _startDrag;
  AnimationController finishSwipe;
  int index;

  @override
  void initState(){
    super.initState();
    finishSwipe = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    )
      ..addListener((){
        setState(() {
          _scrollPercent = lerpDouble(_scrollPercent, _scrollPercent.round(), finishSwipe.value);
          if (_scrollPercent == 1.0) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Marked for Review',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  )
                )
              )
            );
            reviewCards.add(widget.cardDeck[index]);
            widget.cardDeck.removeAt(index);
            index -= 1;
            _scrollPercent = 0.0;
          } else if (_scrollPercent == -1.0) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.blue,
                content: Text(
                  'Mastered',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  )
                )
              )
            );
            widget.cardDeck.removeAt(index);
            index -= 1;
            _scrollPercent = 0.0;
          }
        });
      });
  }

  void _handleSwipeStart(DragStartDetails details) {
    _startDrag = details.globalPosition;
    _scrollPercent = 0.0;
  }

  void _handleSwipeUpdate(DragUpdateDetails details) {
    Offset _currentDrag = details.globalPosition;
    double _dragDistance = _currentDrag.dx - _startDrag.dx;
    setState((){
      _scrollPercent = _dragDistance / context.size.width;
    });
  }

  void _handleSwipeEnd(DragEndDetails details) {
    _startDrag = null;
    finishSwipe.forward(from: 0.0);
  }

  Matrix4 _buildCardProjection() {
    final perspective = 0.002;
    final radius = 1.0;
    final angle = -_scrollPercent * 3.14 / 8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;
    projection *= new Matrix4.translationValues(
        horizontalTranslation + (rotationPointMultiplier * 300.0), 0.0, 0.0) *
        new Matrix4.rotationY(angle) *
        new Matrix4.translationValues(0.0, 0.0, radius) *
        new Matrix4.translationValues(-rotationPointMultiplier * 300.0, 0.0, 0.0);

    return projection;
  }

  Widget _activeCard(){
    return Container (
        margin: EdgeInsets.fromLTRB(12.0, (index + 1) * widget.offSet, 12.0, 0.0),
        child: GestureDetector(
            onHorizontalDragStart: _handleSwipeStart,
            onHorizontalDragUpdate: _handleSwipeUpdate,
            onHorizontalDragEnd: _handleSwipeEnd,
            onTap: () {Tts.speak(widget.cardDeck[index].name);},
            child: FractionalTranslation(
                translation: Offset(_scrollPercent, 0.0),
                child: Transform(
                    transform: _buildCardProjection(),
                    child: RenderCard(
                      name: widget.cardDeck[index].name,
                    )
                )
            )
        )
    );
  }

  Widget _inactiveCards(List<StudyCard> cards, int index) {
    if (index == 0) {
      return Container(
          margin: EdgeInsets.fromLTRB(12.0, (index + 1) * widget.offSet, 12.0, 0.0),
          child: RenderCard(
            name: cards[0].name,
          )
      );
    } else {
      return Stack (
          children: [
            _inactiveCards(cards, index - 1),
            Container(
                margin: EdgeInsets.fromLTRB(12.0, (index + 1) * widget.offSet, 12.0, 0.0),
                child: RenderCard(
                  name: cards[index].name,
                )
            )
          ]
      );
    }
  }

  Widget _reviewCards(){
    if ((index == -1) && (reviewCards != null)) {
      for (int i = reviewCards.length - 1; i >= 0; i--) {
        widget.cardDeck.add(reviewCards[i]);
        reviewCards.removeAt(i);
      }
      widget.cardDeck.shuffle();
      index = widget.cardDeck.length;
    }

    return Container (
        margin: EdgeInsets.only(top: 100.0),
        child: Center(
            child: RaisedButton(
                child: Text(
                  'Review $index Cards',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.red,
                elevation: 10.0,
                splashColor: Colors.blue,
                onPressed: (){
                  setState(() {
                  });
                }
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    index = widget.cardDeck.length - 1;
    if (index == -1) {
      if (reviewCards.length > 0) {
        return _reviewCards();
      } else {
        return Container(
          margin: EdgeInsets.only(top: 100.0),
          child: Center(
            child: Text(
              'You are AWESOME!!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    } else if (index == 0){
      return Stack(
          children: [
            _activeCard()
          ]
      );
    } else {
      return Stack(
          children: [
            _inactiveCards(widget.cardDeck, index - 1),
            _activeCard(),
          ]
      );
    }
  }
}