import 'package:flutter/material.dart';
import '../models/elementStructure.dart';
import '../widgets/listTileElement.dart';
import 'package:provider/provider.dart';
import '../Provider/timeTableProvider.dart';

class ElementList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<TimeTableProvider>(context, listen: false).fetchAndSet(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<TimeTableProvider>(
                  child: Center(
                    child: Text('Enter Activities'),
                  ),
                  builder: (ctx, timeTableProviderElement, ch) {
                    print(
                        '${timeTableProviderElement.list.length} is the length of timeTableProviderElement');
                    return timeTableProviderElement.list.length <= 0
                        ? ch
                        : ListView.builder(
                            itemBuilder: (ctx, index) {
                              return ListTileElement(
                                timeTableProviderElement.list[index],
                              );
                            },
                            itemCount: timeTableProviderElement.list.length,
                          );
                  },
                ),
    );
  }
}

//  ListView.builder(
//       itemBuilder: (ctx, index) {
//         return ListTileElement(listOfItem[index], selectHandlerDelete);
//       },
//       itemCount: listOfItem.length,
//     );
