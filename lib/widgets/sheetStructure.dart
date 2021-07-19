import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeTable/widgets/typeofButtonStructure.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:math';
import '../Helper/db.dart';
import '../Provider/timeTableProvider.dart';

class SheetStructure extends StatefulWidget {
  @override
  _SheetStructureState createState() => _SheetStructureState();
}

class _SheetStructureState extends State<SheetStructure> {
  String typeDetectortext;

  DateTime selectedStartingTime;
  DateTime selectedEndingTime;

  void startingTimepicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        selectedStartingTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            pickedTime.hour,
            pickedTime.minute);
      });
    });
  }

  void endingTimepicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (pickedTime) {
        if (pickedTime == null) {
          return;
        }
        setState(
          () {
            selectedEndingTime = DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                pickedTime.hour,
                pickedTime.minute);
          },
        );
      },
    );
  }

  IconData returnsSelectedIcon(String type) {
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

  void onSubmit(
    BuildContext context,
    String selectedType,
    DateTime selectedStartingTime,
    DateTime selectedEndingTime,
  ) {
    if (selectedType == '') {
      return;
    }
    int calculatedHour;
    num calculatedMinute;
    int id;
    id = Random().nextInt(1000000000);
    calculatedHour = (selectedStartingTime.hour - selectedEndingTime.hour);
    calculatedMinute = double.parse(
        ((((selectedStartingTime.minute - selectedEndingTime.minute) / 60)))
            .toStringAsFixed(1));
    if (calculatedMinute.isNegative) {
      calculatedMinute = -1 * calculatedMinute;
    }
    if (calculatedHour.isNegative) {
      calculatedHour = -1 * calculatedHour;
    }
    Provider.of<TimeTableProvider>(context, listen: false).insert(
        iconType: selectedType,
        startingTime: selectedStartingTime.toString(),
        endingTime: selectedEndingTime.toString(),
        noOfHours: calculatedHour,
        noOfMinutes: calculatedMinute);

    Navigator.of(context).pop();
  }

  void typeDetector(String type) {
    typeDetectortext = type;
  }

  String timeFormatconverter({int hours, int minute}) {
    if (hours < 12) {
      if (minute < 10) {
        return '0$hours:0$minute AM';
      } else {
        return '0$hours:$minute AM';
      }
    } else {
      if (hours == 12) {
        if (minute < 10) {
          return '$hours:0$minute PM';
        } else {
          return '$hours:$minute PM';
        }
      } else {
        if (minute < 10) {
          return '${hours - 12}:0$minute PM';
        } else {
          return '${hours - 12}:$minute PM';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,

        // margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              TypeOfButtonStructure(typeDetector),
              SizedBox(height: 40),
              // Divider(
              //   thickness: 2,
              // ),
              SizedBox(height: 20),
              Text(
                'Select time Period',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 20),
              FittedBox(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 5),
                    FlatButton(
                      color: Colors.amber,
                      onPressed: () => startingTimepicker(context),
                      child: Text(
                        'From',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 15),
                    selectedStartingTime == null
                        ? Text(
                            'Add Starting Time',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            timeFormatconverter(
                                hours: selectedStartingTime.hour,
                                minute: selectedStartingTime.minute),
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(width: 30),
                    FlatButton(
                      color: Colors.amber,
                      onPressed: () => endingTimepicker(context),
                      child: Text(
                        'To',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 15),
                    selectedEndingTime == null
                        ? Text(
                            'Add Ending Time',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            timeFormatconverter(
                                hours: selectedEndingTime.hour,
                                minute: selectedEndingTime.minute),
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    elevation: 5,
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (typeDetectortext != null) {
                        if (typeDetectortext.isNotEmpty)
                          onSubmit(context, typeDetectortext,
                              selectedStartingTime, selectedEndingTime);
                      } else {}
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
