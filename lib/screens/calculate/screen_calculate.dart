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
  getLists() async {
    await _responseActivity!.doListActivity(_category.categoryId);
    await _responseCriteria!.doListCriteria(_category.categoryId);

    for (var i = 0; i < _listActivities.length; i++) {
      print(_listActivities[i].activityName);
    }
  }

  @override
  void initState() {
    getLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesaplanan Öneri'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(_category.categoryName),
            Text(_listActivities[0].activityName),
            Text(_listCriterias[0].criteriaName),
            Text(_listCriterias[1].criteriaName),
            Text(_listCriterias[3].criteriaName),
            Text(_listCriterias[4].criteriaName),
          ],
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
    });
  }
}
