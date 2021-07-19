import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './Provider/timeTableProvider.dart';
import './widgets/elementList.dart';
import './widgets/sheetStructure.dart';
import './models/elementStructure.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TimeTableProvider(),
      child: MaterialApp(
        title: 'Time Table',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.black,
          // fontFamily: 'Raleway',
        ),
        home: TimeTable(),
      ),
    );
  }
}

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  // final List<ElementStructure> _itemContainer = [];
  void _modalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SheetStructure();
      },
    );
  }

  // void listSorting(ElementStructure newElement) {
  //   int ind = -1;
  //   for (int i = 0; i < _itemContainer.length - 1; i++) {
  //     if (_itemContainer[0].startingTime.hour >= newElement.endingTime.hour) {
  //       ind = 0;
  //       break;
  //     }
  //     if ((_itemContainer[i].endingTime.hour <= newElement.startingTime.hour) &&
  //         (newElement.endingTime.hour <=
  //             _itemContainer[i + 1].startingTime.hour)) {
  //       ind = i + 1;
  //       break;
  //     }
  //   }
  //   if (!ind.isNegative) {
  //     _itemContainer.insert(ind, newElement);
  //     _itemContainer.removeAt(_itemContainer.length - 1);
  //   } else {
  //     return;
  //   }
  // }

  // void _addNewElement(
  //     {String newType,
  //     DateTime selectedStartingTime,
  //     DateTime selectedEndingTime,
  //     int newId,
  //     String iconSelected,
  //     int totalHours,
  //     num totalMinutes}) {
  //   final newEle = ElementStructure(
  //       type: newType,
  //       startingTime: selectedStartingTime,
  //       endingTime: selectedEndingTime,
  //       id: newId,
  //       iconType: iconSelected,
  //       noOfHours: totalHours,
  //       noOfminutes: totalMinutes);
  //   setState(
  //     () {
  //       _itemContainer.add(newEle);
  //       listSorting(newEle);
  //     },
  //   );
  // }

  // void _deleteElement(int id) {
  //   setState(() {
  //     _itemContainer.removeWhere((element) {
  //       return element.id == id;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text(
        'Time Table',
        style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _modalSheet(context),
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: Container(
        child: Column(
          children: <Widget>[
            Container( // could use expanded instead of MediaQuerry
              height: (MediaQuery.of(context).size.height -
                  appbar.preferredSize.height -
                  MediaQuery.of(context).padding.top),
              child: ElementList(),
            )
          ],
        ),
      ),
    );
  }
}
