import 'package:flutter/material.dart';

class TypeOfButtonStructure extends StatefulWidget {
  // final String type;
  final Function selecHandler;
  TypeOfButtonStructure(this.selecHandler);

  @override
  _TypeOfButtonStructureState createState() => _TypeOfButtonStructureState();
}

class _TypeOfButtonStructureState extends State<TypeOfButtonStructure> {
  static final List<String> listOfbuttons = [
    'Excercise',
    'Sleep',
    'Study',
    'Play',
    'Break',
    'Eat',
    'Travel',
    'Work',
    'School/College',
    'Others'
  ];
  String currentItemSelected ;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
          child: Row(
        children: <Widget>[
          DropdownButton<String>( 
            style: TextStyle(color:Colors.amber ,fontSize: 20,fontWeight: FontWeight.bold),

            elevation: 30,
            items: listOfbuttons.map((dropDownItem) {
              return DropdownMenuItem<String>( 
                  value: dropDownItem, child: Text(dropDownItem));
            }).toList(),
            onChanged: (selectedItem) {
              setState(
                () {
                  currentItemSelected = selectedItem;
                  widget.selecHandler(currentItemSelected);
                },
              );
            },
            value: currentItemSelected,
          ),
          SizedBox(width: 20),
          currentItemSelected==null?Text('Type Selected : Add a type'): Text('Type Selected : $currentItemSelected')
        ],
      ),
    );
  }
}
