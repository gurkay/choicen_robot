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
import 'package:flutter/rendering.dart';
import 'components/get_calculate.dart';

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
        if (_listTextEditingController[_listCount].text.isEmpty) {
          return;
        }
      }
    }

    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        _listEnteredAmount
            .add(double.parse(_listTextEditingController[_listCount].text));

        if (_listEnteredAmount[_listCount].isInfinite) {
          return;
        }
      }
    }

    List<double> generalTotalUtilityValue = GetCalculate(
      row: _listActivities.length,
      col: _listCriterias.length,
      listEnteredAmount: _listEnteredAmount,
      listCriterias: _listCriterias,
    ).generalTotalUtilityValue();

    for (int i = 0; i < _listActivities.length; i++) {
      print(
          '${_listActivities[i].activityName}:::${generalTotalUtilityValue[i].toStringAsFixed(3)}');
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
                      Container(
                        width: size.width * 1.0,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.purple[400],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _listActivities[i].activityName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                        height: 10,
                      ),
                      for (var j = 0;
                          j < _listCriterias.length;
                          j++, _listCount++)
                        RoundedInputField(
                          hintText: '${_listCriterias[j].criteriaName} ',
                          controller: _listTextEditingController[_listCount],
                          onChanged: (_) => _submitData,
                        ),
                      const Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                        height: 10,
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
