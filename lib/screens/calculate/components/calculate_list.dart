import 'package:choicen_robot/models/conclution.dart';
import 'package:choicen_robot/models/conclution_finish.dart';
import 'package:flutter/material.dart';

class CalculateList extends StatelessWidget {
  final List<Conclution> conclutions;
  final List<ConclutionFinish> conclutionFinies;
  final Function deleteCalculate;

  CalculateList(
    this.conclutions,
    this.conclutionFinies,
    this.deleteCalculate,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.85,
      child: conclutions.isEmpty
          ? const Center(
              child: Text('Hesaplanacak Verileri Giriniz'),
            )
          : ListView.builder(
              itemCount: conclutions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('${conclutions[index].conclutionName}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteCalculate(conclutions[index].conclutionId),
                        ),
                      ),
                      for (var i = 0; i < conclutionFinies.length; i++)
                        conclutions[index].conclutionId ==
                                conclutionFinies[i].conclutionId
                            ? Text(
                                '${conclutionFinies[i].activityName} : ${conclutionFinies[i].conclutionFinishValue}')
                            : Container(),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
