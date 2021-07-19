import 'package:flutter/material.dart';
import 'package:timeTable/Provider/timeTableProvider.dart';

import '../models/elementStructure.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class ListTileElement extends StatelessWidget {
  final ElementStructure _element;
  ListTileElement(this._element);
  // void f1() {
  //   ElementDetails();
  // }
  IconData iconType(String type) {
    IconData finalIcon;
    switch (type) {
      case 'Excercise':
        finalIcon = FontAwesome.bicycle;

        break;
      case 'Sleep':
        finalIcon = MaterialCommunityIcons.sleep;
        break;
      case 'Study':
        finalIcon = Entypo.book;
        break;
      case 'Play':
        finalIcon = MaterialCommunityIcons.soccer;
        break;
      case 'Break':
        finalIcon = Entypo.stopwatch;
        break;
      case 'Eat':
        finalIcon = Ionicons.md_restaurant;
        break;
      case 'Travel':
        finalIcon = MaterialCommunityIcons.train;
        break;
      case 'Work':
        finalIcon = FontAwesome.briefcase;
        break;
      case 'School/College':
        finalIcon = MaterialCommunityIcons.school;
        break;
      default:
        finalIcon = AntDesign.smileo;
    }
    return finalIcon;
  }

  String timeConverter({String whocalled, int time}) {
    String convertedStartingMinutes;
    convertedStartingMinutes = _element.startingTime.minute < 10
        ? '0${_element.startingTime.minute}'
        : '${_element.startingTime.minute}';
    String convertedEndingMinutes;
    convertedEndingMinutes = _element.endingTime.minute < 10
        ? '0${_element.endingTime.minute}'
        : '${_element.endingTime.minute}';

    if (whocalled == 'startingTime') {
      if (time < 12) {
        return 'From :${_element.startingTime.hour}:$convertedStartingMinutes AM';
      } else {
        if (_element.startingTime.hour == 12) {
          return 'From :${_element.startingTime.hour}:$convertedStartingMinutes PM';
        } else {
          int convertedTime = _element.startingTime.hour - 12;
          return 'From :$convertedTime:$convertedStartingMinutes PM';
        }
      }
    } else {
      if (time < 12) {
        return 'From :${_element.endingTime.hour}:$convertedEndingMinutes AM';
      } else {
        if (_element.endingTime.hour == 12) {
          return 'From :${_element.endingTime.hour}:$convertedEndingMinutes PM';
        } else {
          int convertedTime = _element.endingTime.hour - 12;
          return 'From :$convertedTime:$convertedEndingMinutes PM';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // f();
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(2),
      child: Container(
        child: ListTile(
          // onTap: f1, //LATER IT WILL TRIGGER NEW PAGE
          leading: Icon(iconType(_element.iconType)),
          title: Text(
            _element.iconType,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: FittedBox(
            child: Row(
              children: <Widget>[
                Text(
                  timeConverter(
                      whocalled: 'startingTime',
                      time: _element.startingTime.hour),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                ),

                SizedBox(width: 5),
                Text(
                  timeConverter(
                      whocalled: 'endingTime', time: _element.endingTime.hour),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                ),

                // SizedBox(width: 10),
                Text(
                  '(${_element.noOfHours + _element.noOfminutes}H)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          trailing: FlatButton(
            child: Icon(Icons.delete),
            onPressed: () {
              Provider.of<TimeTableProvider>(context, listen: false)
                  .deleteActivity(_element.id);
              //return selectHandlerDelete(_element.id);
            },
          ),
        ),
      ),
    );
  }
}
