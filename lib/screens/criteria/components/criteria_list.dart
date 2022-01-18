import 'package:choicen_robot/models/criteria.dart';
import 'package:flutter/material.dart';

class CriteriaList extends StatelessWidget {
  final List<Criteria> criterias;
  final Function deleteCriteria;
  CriteriaList(
    this.criterias,
    this.deleteCriteria,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.85,
      child: criterias.isEmpty
          ? const Center(
              child: Text('Kriter Ekleyiniz'),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    title: Text('${criterias[index].criteriaName}'),
                    subtitle: Text(
                        'Yüksek Miktar Olmasi İyidir : ${criterias[index].criteriaBigValuePerfect}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          deleteCriteria(criterias[index].criteriaId),
                    ),
                  ),
                );
              },
              itemCount: criterias.length,
            ),
    );
  }
}
