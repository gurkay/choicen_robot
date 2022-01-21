import 'dart:math';

import 'package:choicen_robot/components/rounded_input_field.dart';
import 'package:choicen_robot/models/activity.dart';
import 'package:choicen_robot/models/calculate.dart';
import 'package:choicen_robot/models/category.dart';
import 'package:choicen_robot/models/criteria.dart';
import 'package:choicen_robot/services/response/response_activity.dart';
import 'package:choicen_robot/services/response/response_calculate.dart';
import 'package:choicen_robot/services/response/response_criteria.dart';
import 'package:flutter/material.dart';

class ScreenCalculate extends StatefulWidget {
  static String routeName = '/screen_calculate';
  final Category category;

  ScreenCalculate({required this.category});

  @override
  State<ScreenCalculate> createState() => _ScreenCalculateState(category);
}

class _ScreenCalculateState extends State<ScreenCalculate>
    implements CallBackCalculate, CallBackActivity, CallBackCriteria {
  Category _category;
  ResponseCalculate? _responseCalculate;
  ResponseActivity? _responseActivity;
  ResponseCriteria? _responseCriteria;
  _ScreenCalculateState(this._category) {
    _responseCalculate = ResponseCalculate(this);
    _responseActivity = ResponseActivity(this);
    _responseCriteria = ResponseCriteria(this);
  }
  List<Activity> _listActivities = [];
  List<Criteria> _listCriterias = [];
  List<Widget> _listCardWidget = [];

  final List<TextEditingController> _listTextEditingController = [];
  List<double> _listEnteredAmount = [];

  void _submitData() {
    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        print(_listTextEditingController[_listCount].text);
        if (_listTextEditingController[_listCount].text.isEmpty) {
          return;
        }
      }
    }

    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        _listEnteredAmount
            .add(double.parse(_listTextEditingController[_listCount].text));
        print(_listEnteredAmount[_listCount]);
        if (_listEnteredAmount[_listCount].isInfinite) {
          return;
        }
      }
    }

    int row = _listActivities.length;
    int col = _listCriterias.length;

    var arr = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );

    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        arr[i][j] = _listEnteredAmount[_listCount];
        print('arr:::${arr[i][j]}');
      }
    }

    var betterValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        if (betterValue[0][j] == 0.0) {
          betterValue[0][j] = arr[i][j];
        }
        if (arr[i][j] < betterValue[0][j]) {
          betterValue[0][j] = arr[i][j];
        }
      }
    }
    for (int j = 0; j < _listCriterias.length; j++) {
      print('betterValue:::${betterValue[0][j]}');
    }
    var bestValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        if (arr[i][j] > bestValue[0][j]) {
          bestValue[0][j] = arr[i][j];
        }
      }
    }
    for (int j = 0; j < _listCriterias.length; j++) {
      print('bestValue:::${bestValue[0][j]}');
    }

    var calculateEntropiValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        calculateEntropiValue[0][j] = double.parse(
            (calculateEntropiValue[0][j] + arr[i][j]).toStringAsFixed(3));
      }
    }
    for (int j = 0; j < _listCriterias.length; j++) {
      print('calculateEntropiValue:::${calculateEntropiValue[0][j]}');
    }

    var calculateNormalizeEntropiValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        calculateNormalizeEntropiValue[i][j] = double.parse(
            (arr[i][j] / calculateEntropiValue[0][j]).toStringAsFixed(3));
      }
    }

    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        print(
            'calculateNormalizeEntropiValue:::${calculateNormalizeEntropiValue[i][j]}');
      }
    }

    var calculateLogEntropiValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        calculateLogEntropiValue[i][j] = double.parse(
            (calculateNormalizeEntropiValue[i][j] *
                    log(calculateNormalizeEntropiValue[i][j]))
                .toStringAsFixed(3));
      }
    }

    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        print('calculateLogEntropiValue:::${calculateLogEntropiValue[i][j]}');
      }
    }

    var totalLogEntropiValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        totalLogEntropiValue[0][j] = double.parse((totalLogEntropiValue[0][j] + calculateLogEntropiValue[i][j]).toStringAsFixed(3));
      }
    }

      for (int j = 0; j < _listCriterias.length; j++) {
        print('totalLogEntropiValue:::${totalLogEntropiValue[0][j]}');
      }


    double activitiesLogValue = 1 / log(_listActivities.length);

    var entropiValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int j = 0; j < _listCriterias.length; j++) {
      entropiValue[0][j] = double.parse(
          (activitiesLogValue * totalLogEntropiValue[0][j] * (-1))
              .toStringAsFixed(3));
    }

    for (int j = 0; j < _listCriterias.length; j++) {
      print('entropiValue:::${entropiValue[0][j]}');
    }

    var oneEntropiValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int j = 0; j < _listCriterias.length; j++) {
      oneEntropiValue[0][j] = 1 - entropiValue[0][j];
    }

    for (int j = 0; j < _listCriterias.length; j++) {
      print('oneEntropiValue:::${oneEntropiValue[0][j]}');
    }

    double totalOneEntropiValue = 0.0;
    for (int j = 0; j < _listCriterias.length; j++) {
      totalOneEntropiValue = double.parse(
          (totalOneEntropiValue + oneEntropiValue[0][j]).toStringAsFixed(3));
    }

    print('totalOneEntropiValue:::${totalOneEntropiValue}');

    var entropiWeightValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int j = 0; j < _listCriterias.length; j++) {
      entropiWeightValue[0][j] = double.parse(
          (oneEntropiValue[0][j] / totalOneEntropiValue).toStringAsFixed(3));
    }

    for (int j = 0; j < _listCriterias.length; j++) {
      print('entropiWeightValue:::${entropiWeightValue[0][j]}');
    }

    var arrayBetterValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        arrayBetterValue[i][j] =
            double.parse((arr[i][j] - betterValue[0][j]).toStringAsFixed(3));
      }
    }

    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        print('arrayBetterValue:::${arrayBetterValue[i][j]}');
      }
    }

    var arrayBestValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int j = 0; j < _listCriterias.length; j++) {
      arrayBestValue[0][j] = double.parse(
          (bestValue[0][j] - betterValue[0][j]).toStringAsFixed(3));
    }

    for (int j = 0; j < _listCriterias.length; j++) {
      print('arrayBestValue:::${arrayBestValue[0][j]}');
    }

    var normalizedUtilityValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        normalizedUtilityValue[i][j] = double.parse(
            (arrayBetterValue[i][j] / arrayBestValue[0][j]).toStringAsFixed(3));
      }
    }

    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        print('normalizedUtilityValue:::${normalizedUtilityValue[i][j]}');
      }
    }

    var totalUtilityValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        totalUtilityValue[i][j] = double.parse(
            (normalizedUtilityValue[i][j] * entropiWeightValue[0][j])
                .toStringAsFixed(3));
      }
    }

    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        print('totalUtilityValue:::${totalUtilityValue[i][j]}');
      }
    }

    var generalTotalUtilityValue = List.generate(
      row,
      (index) => List.filled(col, 0.0, growable: false),
    );
    for (int i = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++) {
        generalTotalUtilityValue[i][0] = double.parse(
            (generalTotalUtilityValue[i][0] + totalUtilityValue[i][j])
                .toStringAsFixed(3));
      }
    }

    for (int i = 0; i < _listActivities.length; i++) {
      print(
          '${_listActivities[i].activityName}:::${generalTotalUtilityValue[i][0]}');
    }
  }

  getLists() async {
    await _responseActivity!.doListActivity(_category.categoryId);
    await _responseCriteria!.doListCriteria(_category.categoryId);
  }

  @override
  void initState() {
    getLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesaplanan Öneri'),
        actions: [
          IconButton(
            onPressed: _submitData,
            icon: Icon(Icons.calculate),
          ),
        ],
      ),
      body: Container(
        height: size.height * 0.80,
        child: ListView.builder(
          itemCount: _listActivities.length,
          itemBuilder: (ctx, index) {
            for (var i = 0, _listCount = 0; i < _listActivities.length; i++) {
              _listCardWidget.add(
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  child: Column(
                    children: [
                      Text(_listActivities[i].activityName),
                      for (var j = 0;
                          j < _listCriterias.length;
                          j++, _listCount++)
                        RoundedInputField(
                          hintText: '${_listCriterias[j].criteriaName} ',
                          controller: _listTextEditingController[_listCount],
                          onChanged: (_) => _submitData,
                        ),
                    ],
                  ),
                ),
              );
            }
            return _listCardWidget[index];
          },
        ),
      ),
    );
  }

  @override
  void onErrorCalculate(String error) {
    // TODO: implement onErrorCalculate
  }

  @override
  void onSuccessDoDeleteCalculate(int result) {
    // TODO: implement onSuccessDoDeleteCalculate
  }

  @override
  void onSuccessDoInsertCalculate(Calculate calculate) {
    // TODO: implement onSuccessDoInsertCalculate
  }

  @override
  void onSuccessDoListCalculate(List<Calculate> calculates) {
    // TODO: implement onSuccessDoListCalculate
  }

  @override
  void onErrorActivity(String error) {
    // TODO: implement onErrorActivity
  }

  @override
  void onErrorCriteria(String error) {
    // TODO: implement onErrorCriteria
  }

  @override
  void onSuccessDoDeleteActivity(int result) {
    // TODO: implement onSuccessDoDeleteActivity
  }

  @override
  void onSuccessDoDeleteCriteria(int result) {
    // TODO: implement onSuccessDoDeleteCriteria
  }

  @override
  void onSuccessDoInsertActivity(Activity activity) {
    // TODO: implement onSuccessDoInsertActivity
  }

  @override
  void onSuccessDoInsertCriteria(Criteria criteria) {
    // TODO: implement onSuccessDoInsertCriteria
  }

  @override
  void onSuccessDoListActivity(List<Activity> activities) {
    setState(() {
      _listActivities = activities;
    });
  }

  @override
  void onSuccessDoListCriteria(List<Criteria> criterias) {
    setState(() {
      _listCriterias = criterias;
      for (var i = 0, _listCount = 0; i < _listActivities.length; i++) {
        for (var j = 0; j < _listCriterias.length; j++, _listCount++) {
          _listTextEditingController.add(TextEditingController());
        }
      }
    });
  }
}
