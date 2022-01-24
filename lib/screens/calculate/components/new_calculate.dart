import 'package:flutter/material.dart';

class NewCalculate extends StatefulWidget{
  final Function addTx;
  NewCalculate(this.addTx);
  
  @override
  _NewCalculateState createState() => _NewCalculateState();
}

class _NewCalculateState extends State<NewCalculate> {
  final List<TextEditingController> _listTextEditingController = [];
  List<double> _listEnteredAmount = [];

   void _submitData() {
    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        if (_listTextEditingController[_listCount].text.isEmpty) {
          return;
        }
      }
    }

    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        _listEnteredAmount
            .add(double.parse(_listTextEditingController[_listCount].text));
        if (_listEnteredAmount[_listCount].isNaN) {
          return;
        }
      }
    }

    GetCalculate getCalculate = GetCalculate(
      row: _listActivities.length,
      col: _listCriterias.length,
      listEnteredAmount: _listEnteredAmount,
      listCriterias: _listCriterias,
    );

    List<double> generalTotalUtilityValue =
        getCalculate.generalTotalUtilityValue();
    double avarageTotalUtility =
        getCalculate.avaregeGeneralTotalUtilityValue(generalTotalUtilityValue);
    List<Map<String, dynamic>> items = [];

    for (var i = 0; i < generalTotalUtilityValue.length; i++) {
      items.add({
        'activityName': _listActivities[i].activityName,
        'value': generalTotalUtilityValue[i],
      });
    }

    items.sort((a, b) => b['value'].compareTo(a['value']));

    for (var i = 0; i < items.length; i++) {
      if (items[i]['value'] > avarageTotalUtility) {
        print('${items[i]['activityName']} ::: ${items[i]['value']}');
      }
    }
  }
  
}
