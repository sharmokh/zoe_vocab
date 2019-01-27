import 'package:flutter/material.dart';

class AlphabetDialog extends StatefulWidget {
  const AlphabetDialog({this.onValueChange, this.initialValue});

  final List<String> initialValue;
  final void Function(List<String>) onValueChange;

  @override
  State createState() => new AlphabetDialogState();
}

class AlphabetDialogState extends State<AlphabetDialog> {
  List<String> alphabets = ['ALL','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
  List<String> _selectedLetters;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedLetters = widget.initialValue;
  }

  Widget _createButtons(String name) {
    bool buttonToggle;
    if (_selectedLetters.contains(name))
      buttonToggle = true;
    else buttonToggle = false;
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      child: Text('${name}'),
      elevation: 4.0,
      splashColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      onPressed: () {
        setState(() {
          if (name == 'ALL'){
            for (int i = 1; i < alphabets.length; i++)
              _selectedLetters.remove(alphabets[i]);
          } else {
            _selectedLetters.remove('ALL');
          }
          if (buttonToggle)
            _selectedLetters.remove(name);
          else _selectedLetters.add(name);
        });
        widget.onValueChange(_selectedLetters);
      },
      color: buttonToggle ? Colors.lightBlueAccent : Colors.grey,
    );
  }

  Widget build(BuildContext contect) {
    return AlertDialog(
        title: Text('Choose Letters'),
        content: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: GridView.builder(
                itemCount: alphabets.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (context, index){
                  return Container(
                      padding: EdgeInsets.all(6.0),
                      child: _createButtons(alphabets[index])
                  );
                }
            )
        )
    );
  }
}