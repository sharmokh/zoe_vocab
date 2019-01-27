import 'package:flutter/material.dart';

class RenderCard extends StatelessWidget {
  final String name;

  const RenderCard({
    Key key,
    @required this.name,
  }) : assert(name != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width - 24.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        boxShadow: [BoxShadow(color:Colors.black, blurRadius: 20.0)],
        image: DecorationImage(
          image: AssetImage('images/' + name + '.jpg'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}