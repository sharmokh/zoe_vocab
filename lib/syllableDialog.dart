import 'package:flutter/material.dart';

class SyllableDialog extends StatefulWidget {
  const SyllableDialog({this.onValueChange, this.initialValue});

  final List<String> initialValue;
  final void Function(List<String>) onValueChange;

  @override
  State createState() => new SyllableDialogState();
}

class SyllableDialogState extends State<SyllableDialog> {
  List<String> syllables = ['Every Word', '(1) Monosyllable Words', '(2) Disyllables Words', 'Multisyllable Words'];
  List<String> _selectedSyllables;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedSyllables = widget.initialValue;
  }

  Widget _createButtons(String name) {
    bool buttonToggle;
    if (_selectedSyllables.contains(name))
      buttonToggle = true;
    else buttonToggle = false;
    return RaisedButton(
      padding: EdgeInsets.all(10.0),
      child: Text('${name}'),
      elevation: 4.0,
      splashColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        setState(() {
          if (name == 'Every Word'){
            for (int i = 1; i < syllables.length; i++)
              _selectedSyllables.remove(syllables[i]);
          } else {
            _selectedSyllables.remove('Every Word');
          }
          if (buttonToggle)
            _selectedSyllables.remove(name);
          else _selectedSyllables.add(name);
        });
        widget.onValueChange(_selectedSyllables);
      },
      color: buttonToggle ? Colors.lightBlueAccent : Colors.grey,
    );
  }

  Widget build(BuildContext contect) {
    return AlertDialog(
      title: Text('Choose number of Syllables'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 200.0,
        child: ListView.builder(
          itemCount: syllables.length,
          itemBuilder: (context, index){
            return Container(
                padding: EdgeInsets.all(6.0),
                child: _createButtons(syllables[index])
            );
          }
        )
      ),
    );
  }
}