import 'package:flutter/material.dart';

class ElementStructure {
  int id;
  // String type;
  DateTime startingTime;
  DateTime endingTime;
  String iconType;
  num noOfHours;
  num noOfminutes;
  
  ElementStructure(
      {this.id,
      this.startingTime,
      // this.type,
      this.endingTime,
      this.iconType,
      this.noOfHours,
      this.noOfminutes});
}
