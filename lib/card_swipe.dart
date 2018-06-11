import 'package:flutter/material.dart';
import 'package:zoe_vocab/cards.dart';

class CardSwipe extends StatefulWidget {
  final SingleCard swipeCard;

  const CardSwipe({
    Key key,
    @required this.swipeCard,
  })  : assert(swipeCard != null),
        super(key: key);

  @override
  _CardSwipeState createState() => new _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {
  double _scrollPercent = 0.0;
  Offset _startDrag;

  void _handleSwipeStart(DragStartDetails details) {
    _startDrag = details.globalPosition;
    _scrollPercent = 0.0;
  }

  void _handleSwipeUpdate(DragUpdateDetails details) {
    Offset _currentDrag = details.globalPosition;
    double _dragDistance = _currentDrag.dx - _startDrag.dx;
    _scrollPercent = _dragDistance / context.size.width;
    print(_scrollPercent);
  }

  void _handleSwipeEnd(DragEndDetails details) {
    _scrollPercent = 0.0;
    print(_scrollPercent);
  }

  Matrix4 _buildCardProjection() {
    final perspective = 0.002;
    final radius = 1.0;
    final angle = _scrollPercent * 3.14 / 8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0, 0, 1 / radius)
      ..setEntry(1, 1, 1 / radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0);

    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;
    print('Angle: $angle');
    projection *= new Matrix4.translationValues(
        horizontalTranslation + (rotationPointMultiplier * 300.0), 0.0, 0.0) *
        new Matrix4.rotationY(angle) *
        new Matrix4.translationValues(0.0, 0.0, radius) *
        new Matrix4.translationValues(-rotationPointMultiplier * 300.0, 0.0, 0.0);

    return projection;
  }

  /*Widget _buildCard(){
    return FractionalTranslation(
      translation: Offset(_scrollPercent, 0.0),
      child: Transform(
        transform: _buildCardProjection(),
        child: singleCard(
          imagePath: 'http://www.freepngimg.com/download/banana/8-banana-png-image.png',
          name: 'Banana',
          offSet: 80.0,
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _handleSwipeStart,
      onHorizontalDragUpdate: _handleSwipeUpdate,
      onHorizontalDragEnd: _handleSwipeEnd,
      child: FractionalTranslation(
        translation: Offset(_scrollPercent, 0.0),
        child: widget.swipeCard,
      ),
    );
  }
}