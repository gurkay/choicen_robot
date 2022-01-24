import 'package:choicen_robot/models/activity.dart';
import 'package:choicen_robot/models/calculate.dart';
import 'package:flutter/material.dart';

class CalculateList extends StatelessWidget {
  final List<Map<String, dynamic>> itemsCalculate;
  final Function deleteCalculate;

  CalculateList(
    this.itemsCalculate,
    this.deleteCalculate,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.85,
      child: itemsCalculate.isEmpty
          ? const Center(
              child: Text('Hesaplanacak Verileri Giriniz'),
            )
          : ListView.builder(
              itemCount: itemsCalculate.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    title: Text('${itemsCalculate[index]['activityName']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          deleteCalculate(itemsCalculate[index]['value']),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
