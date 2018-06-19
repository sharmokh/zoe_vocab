import 'package:flutter/material.dart';

class SingleCard extends StatelessWidget {
  final String imagePath;
  final String name;
  //add category
  //add voice
  //add initial letter

  const SingleCard({
    Key key,
    @required this.imagePath,
    @required this.name,
  }) : assert(imagePath != null),
      assert(name != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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