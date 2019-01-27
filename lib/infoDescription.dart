import 'package:flutter/material.dart';

class InfoDescription extends StatelessWidget {
  InfoDescription({this.description, this.iconName});

  final String description;
  final IconData iconName;

  @override
  Widget build(BuildContext) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container (
            padding: EdgeInsets.all(10.0),
            child: Icon(iconName),
          ),
          Flexible (
            child: Column (
              children: [
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ]
            )
          )
        ]
      )
    );
  }
}