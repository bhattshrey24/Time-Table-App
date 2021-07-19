import 'package:flutter/material.dart';
import 'package:timeTable/models/elementStructure.dart';
import '../Helper/db.dart';

class TimeTableProvider with ChangeNotifier {
  List<ElementStructure> _list = [];
  List<ElementStructure> get list {
    return [..._list];
  }

  Future<void> fetchAndSet() async {
    print('inside fetch and set function');
    final dbList = await AppDB.getData('time_table');
    print('list length is ${dbList.length}');
    // List<ElementStructure> dummyList = [];
    _list = dbList.map(
      (element) {
        return ElementStructure(
          id: element['id'],
          iconType: element['iconType'],
          noOfHours: element['noOfHours'],
          noOfminutes: element['noOfMinutes'],
          endingTime: DateTime.parse(element['endingTime']),
          startingTime: DateTime.parse(element['startingTime']),
        );
      },
    ).toList();
    // int lb = 0;
    // int ub = _list.length - 1;
    // List<ElementStructure> listcopy2 = _list;
    // mergeSort(listcopy: listcopy2, lb: lb, ub: ub);
    // _list = listcopy2;
    List<ElementStructure> dummyList = [];
    for (int i = 0; i < _list.length; i++) {
      listSorting(_list.elementAt(i), dummyList);
    }
    _list = dummyList;
    notifyListeners();
  }

  void listSorting(
      ElementStructure newElement, List<ElementStructure> dummyList) {
    int ind = -1;
    print('dummyList length is ${dummyList.length}');
    for (int i = 0; i < dummyList.length - 1; i++) {
      print('inside else of dummylist check');
      if (dummyList[0].startingTime.hour >= newElement.endingTime.hour) {
        ind = 0;
        break;
      }
      if ((dummyList[i].endingTime.hour <= newElement.startingTime.hour) &&
          (newElement.endingTime.hour <= dummyList[i + 1].startingTime.hour)) {
        ind = i + 1;
        break;
      }
    }

    if (!ind.isNegative) {
      dummyList.insert(ind, newElement);
      //dummyList.removeAt(_list.length - 1);
    } else {
      dummyList.add(newElement);
      return;
    }
  }

  Future<void> insert(
      {String iconType,
      String startingTime,
      String endingTime,
      String selectedType,
      int noOfHours,
      num noOfMinutes}) async {
    final db = await AppDB.getData('time_table');
    AppDB.insert('time_table', {
      'iconType': iconType,
      'startingTime': startingTime,
      'endingTime': endingTime,
      'noOfHours': noOfHours,
      'noOfMinutes': noOfMinutes
    }).then((value) => fetchAndSet());
    notifyListeners();
  }

  Future<void> deleteActivity(int studId) async {
    final db = await AppDB.database();
    if (studId != null) {
      await db.delete('time_table', where: 'id = ?', whereArgs: [studId]);
    }
    fetchAndSet();
  }

  // void mergeSort({List<ElementStructure> listcopy, int lb, int ub}) {
  //   print('inside mergeSort function');

  //   int mid = 0;
  //   if (lb < ub) {
  //     mid = ((lb + ub) / 2).toInt(); // working fine
  //     // print('$mid is value of mid , lb is $lb , ub is $ub');
  //   }
  //   // List<ElementStructure> listcopy2 = _list;

  //   mergeSort(listcopy: listcopy, lb: lb, ub: mid);
  //   mergeSort(listcopy: listcopy, lb: mid + 1, ub: ub);

  //   merge(listcopy, lb, mid, ub);
  //   // _list = listcopy2;
  // }

  // merge(
  //   List<ElementStructure> listcopy,
  //   int lb,
  //   int mid,
  //   int ub,
  // ) {
  //   print('inside merge function');
  //   int i = lb;
  //   int j = mid + 1;
  //   int k = lb;
  //   // List<ElementStructure> a = [];
  //   List<ElementStructure> dummyList = [];

  //   while (i <= mid && j <= ub) {
  //     if (_list.elementAt(i).startingTime.hour <=
  //         _list.elementAt(j).startingTime.hour) {
  //       // _list.insert(k, a[i]);
  //       dummyList.insert(k, listcopy.elementAt(i));
  //       // b[k] = a[i];
  //       i++;
  //     } else {
  //       dummyList.insert(k, listcopy.elementAt(j));
  //       // b[k] = a[j];
  //       j++;
  //     }
  //     k++;
  //   }
  //   if (i > mid) {
  //     while (j <= ub) {
  //       dummyList.insert(k, listcopy.elementAt(j));

  //       j++;
  //       k++;
  //     }
  //   } else {
  //     while (i <= mid) {
  //       dummyList.insert(k, listcopy.elementAt(i));
  //       i++;
  //       k++;
  //     }
  //   }
  // }
}
