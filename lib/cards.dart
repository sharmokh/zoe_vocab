import 'package:flutter/material.dart';

class SingleCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final double offSet;

  const SingleCard({
    Key key,
    @required this.imagePath,
    @required this.name,
    @required this.offSet,
  }) : assert(imagePath != null),
      assert(name != null),
      assert(offSet != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.0, offSet, 12.0, 12.0),
      height: MediaQuery.of(context).size.width - 24.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        boxShadow: [BoxShadow(color:Colors.black, blurRadius: 20.0)]
      ),
      child: Center(
        child: Image.network(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}