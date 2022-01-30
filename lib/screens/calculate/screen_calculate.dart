import 'dart:collection';
import 'dart:math';

import 'package:choicen_robot/components/rounded_input_field.dart';

import 'package:choicen_robot/models/activity.dart';
import 'package:choicen_robot/models/calculate.dart';
import 'package:choicen_robot/models/category.dart';
import '../../models/conclution.dart';
import 'package:choicen_robot/models/conclution_finish.dart';
import 'package:choicen_robot/models/criteria.dart';
import 'package:choicen_robot/screens/arguments/screen_arguments.dart';
import 'package:choicen_robot/screens/calculate/components/damy_data.dart';
import 'package:choicen_robot/screens/calculate/components/new_calc.dart';
import 'package:choicen_robot/services/response/response_activity.dart';
import 'package:choicen_robot/services/response/response_calculate.dart';
import 'package:choicen_robot/services/response/response_conclution.dart';
import 'package:choicen_robot/services/response/response_conclution_finish.dart';
import 'package:choicen_robot/services/response/response_criteria.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/calculate_list.dart';
import 'components/get_calculate.dart';
import 'components/new_calculate.dart';

class ScreenCalculate extends StatefulWidget {
  static String routeName = '/screen_calculate';
  final Category category;

  ScreenCalculate({required this.category});

  @override
  State<ScreenCalculate> createState() => _ScreenCalculateState(category);
}

class _ScreenCalculateState extends State<ScreenCalculate>
    implements
        CallBackCalculate,
        CallBackActivity,
        CallBackCriteria,
        CallBackConclution,
        CallBackConclutionFinish {
  Category _category;
  ResponseCalculate? _responseCalculate;
  ResponseActivity? _responseActivity;
  ResponseCriteria? _responseCriteria;
  ResponseConclution? _responseConclution;
  ResponseConclutionFinish? _responseConclutionFinish;

  _ScreenCalculateState(this._category) {
    _responseCalculate = ResponseCalculate(this);
    _responseActivity = ResponseActivity(this);
    _responseCriteria = ResponseCriteria(this);
    _responseConclution = ResponseConclution(this);
    _responseConclutionFinish = ResponseConclutionFinish(this);
  }
  List<Calculate> _categoryCalculate = [];
  List<Conclution> _listConclutions = [];
  List<ConclutionFinish> _listConclutionFinies = [];
  List<Activity> _listActivities = [];
  List<Criteria> _listCriterias = [];
  List<Widget> _listCardWidget = [];
  List<Map<String, dynamic>> _itemsConclutionFinish = [];
  Calculate _calculate = new Calculate(0, '0', 0, 0, 0);

  final List<TextEditingController> _listTextEditingController = [];
  List<double> _listEnteredAmount = [];

  void _addNewCalculate(List<double> txAmount) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Conclution _conclutionTest = Conclution.withConclutionId(
      DateTime.now().toString(),
      _category.categoryId,
      _category.categoryName,
      DateTime.now().toString(),
    );

    print(
        'screen_calculate:::_conclutionTest.conclutionId:::${_conclutionTest.conclutionId}');
    print(
        'screen_calculate:::_conclutionTest.categoryId:::${_conclutionTest.categoryId}');
    print(
        'screen_calculate:::_conclutionTest.conclutionName:::${_conclutionTest.conclutionName}');
    print(
        'screen_calculate:::_conclutionTest.conclutionDate:::${_conclutionTest.conclutionDate}');
    getLists();

    await _responseConclution!.doInsert(_conclutionTest);

    print('screen_calculate:::_listConclution:::${_listConclutions}');

    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        await _responseCalculate!.doInsert(Calculate(
          sharedPreferences.getInt('userId'),
          _listConclutions.last.conclutionId,
          _listActivities[i].activityId,
          _listCriterias[j].criteriaId,
          txAmount[_listCount],
        ));
      }
    }

    GetCalculate getCalculate = GetCalculate(
      row: _listActivities.length,
      col: _listCriterias.length,
      listEnteredAmount: txAmount,
      listCriterias: _listCriterias,
    );

    List<double> generalTotalUtilityValue =
        getCalculate.generalTotalUtilityValue();
    double avarageTotalUtility =
        getCalculate.avaregeGeneralTotalUtilityValue(generalTotalUtilityValue);

    for (var i = 0; i < generalTotalUtilityValue.length; i++) {
      _itemsConclutionFinish.add({
        'activityName': _listActivities[i].activityName,
        'value': generalTotalUtilityValue[i],
      });
    }

    _itemsConclutionFinish.sort((a, b) => b['value'].compareTo(a['value']));

    for (var i = 0; i < generalTotalUtilityValue.length; i++) {
      if (_itemsConclutionFinish[i]['value'] > avarageTotalUtility) {
        print(
            '${_itemsConclutionFinish[i]['activityName']} ::: ${_itemsConclutionFinish[i]['value']}');
        await _responseConclutionFinish!.doInsert(
          ConclutionFinish.withConclutionId(
            DateTime.now().toString(),
            _listConclutions.last.conclutionId,
            _itemsConclutionFinish[i]['activityName'],
            _itemsConclutionFinish[i]['value'],
          ),
        );
      }
    }

    getLists();

    final newTxConclution = Conclution.withConclutionId(
      _listConclutions.last.conclutionId,
      _category.categoryId,
      _listConclutions.last.conclutionName,
      _listConclutions.last.conclutionDate,
    );

    List<ConclutionFinish> newTxConclutionFinish = [];
    for (var i = 0; i < _listConclutionFinies.length; i++) {
      newTxConclutionFinish.add(
        ConclutionFinish.withConclutionId(
          _listConclutionFinies.last.conclutionFinishId,
          _listConclutionFinies.last.conclutionId,
          _listConclutionFinies.last.activityName,
          _listConclutionFinies.last.conclutionFinishValue,
        ),
      );
    }

    setState(() {
      _listConclutions.add(newTxConclution);
      _listConclutionFinies = newTxConclutionFinish;
    });
  }

  void _startAddCalculate(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewCalculate(
              _addNewCalculate,
              _listActivities,
              _listCriterias,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteCalculate(int id) async {
    await _responseCalculate!.doDelete(id);

    setState(() {
      _categoryCalculate
          .removeWhere((calculate) => calculate.calculateId == id);
    });
  }

  getLists() async {
    await _responseActivity!.doListActivity(_category.categoryId);
    await _responseCriteria!.doListCriteria(_category.categoryId);
    await _responseConclution!.doListConclution(_category.categoryId);
    for (var i = 0; i < _listConclutions.length; i++) {
      await _responseConclutionFinish!
          .doListConclutionFinish(_listConclutions[i].conclutionId);
    }
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
        title: Text('Hesap Verileri'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CalculateList(
              _listConclutions,
              _listConclutionFinies,
              _deleteCalculate,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddCalculate(context),
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
  void onSuccessDoListCalculate(List<Calculate> conclutions) {
    print('screen_calculate:::onSuccessDoListCalculate:::$conclutions');
  }

  @override
  void onErrorActivity(String error) {
    print('screen_calculate:::onErrorActivity:::$error');
  }

  @override
  void onErrorCriteria(String error) {
    print('screen_calculate:::onErrorCriteria:::$error');
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

  @override
  void onErrorConclution(String error) {
    print('screen_calculate:::onErrorConclution:::$error');
  }

  @override
  void onErrorConclutionFinish(String error) {
    print('screen_calculate:::onErrorConclutionFinish:::$error');
  }

  @override
  void onSuccessDoDeleteConclution(int result) {
    // TODO: implement onSuccessDoDeleteConclution
  }

  @override
  void onSuccessDoDeleteConclutionFinish(int result) {
    // TODO: implement onSuccessDoDeleteConclutionFinish
  }

  @override
  void onSuccessDoInsertConclution(Conclution conclution) {
    print(
        'screen_calculate:::onSuccessDoInsertConclution:::${conclution.conclutionName}');
    setState(() {
      _listConclutions.add(conclution);
    });
  }

  @override
  void onSuccessDoInsertConclutionFinish(ConclutionFinish conclutionFinish) {
    setState(() {
      _listConclutionFinies.add(conclutionFinish);
    });
  }

  @override
  void onSuccessDoListConclution(List<Conclution> conclutions) {
    print('screen_calculate:::onSuccessDoListConclution:::$conclutions');
    setState(() {
      _listConclutions = conclutions;
    });
  }

  @override
  void onSuccessDoListConclutionFinish(
      List<ConclutionFinish> conclutionFinies) {
    // setState(() {
    //   _listConclutionFinies = conclutionFinies;
    // });
  }
}
