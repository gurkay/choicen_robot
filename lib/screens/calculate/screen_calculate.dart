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
  List<List<ConclutionFinish>> _listConcFinies = [];
  List<Activity> _listActivities = [];
  List<Criteria> _listCriterias = [];
  List<Widget> _listCardWidget = [];
  List<Map<String, dynamic>> _itemsConclutionFinish = [];
  Calculate _calculate = new Calculate(0, '0', 0, 0, 0);

  final List<TextEditingController> _listTextEditingController = [];
  List<double> _listEnteredAmount = [];

  void _addNewCalculate(List<double> txAmount) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String _conclutionId = DateTime.now().toString();
    String _conclutionName =
        _category.categoryName + ' \n' + DateTime.now().toString() + '\n';
    String _conclutionDate = DateTime.now().toString();

    await _responseConclution!.doInsert(
      Conclution.withConclutionId(
        _conclutionId,
        _category.categoryId,
        _conclutionName,
        _conclutionDate,
      ),
    );

    print('screen_calculate:::txAmount.length:::${txAmount.length}');
    print('screen_calculate:::txAmount[0]:::${txAmount[0]}');
    print(
        'screen_calculate:::_listConclutions:::_conclutionId:::${_conclutionId}');

    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        await _responseCalculate!.doInsert(
          Calculate(
            sharedPreferences.getInt('userId'),
            _conclutionId,
            _listActivities[i].activityId,
            _listCriterias[j].criteriaId,
            txAmount[_listCount],
          ),
        );
      }
    }
    final newTxConclution = Conclution.withConclutionId(
      _conclutionId,
      _category.categoryId,
      _conclutionName,
      _conclutionDate,
    );
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
      setState(() {
        print(
            'screen_calculate:::generalTotalUtilityValue[$i]:::${generalTotalUtilityValue[i]}');
        _itemsConclutionFinish.add(
          {
            'activityName': _listActivities[i].activityName,
            'value': generalTotalUtilityValue[i],
          },
        );
        print(
            'screen_calculate:::_itemsConclutionFinish[$i][value]:::${_itemsConclutionFinish[i]['value']}');
      });
    }

    _itemsConclutionFinish.sort((a, b) => b['value'].compareTo(a['value']));
    final List<ConclutionFinish> newTxConclutionFinies = [];
    for (var i = 0; i < generalTotalUtilityValue.length; i++) {
      print(
          'screen_calculate:::_itemsConclutionFinish[$i][value]:::${_itemsConclutionFinish[i]['value']}');
      print('screen_calculate:::avarageTotalUtility:::${avarageTotalUtility}');
      if (_itemsConclutionFinish[i]['value'] > avarageTotalUtility) {
        print(
            '${_itemsConclutionFinish[i]['activityName']} ::: ${_itemsConclutionFinish[i]['value']}');
        String _conclutionFinishId = DateTime.now().toString();
        await _responseConclutionFinish!.doInsert(
          ConclutionFinish.withConclutionFinishId(
            _conclutionFinishId,
            _conclutionId,
            _itemsConclutionFinish[i]['activityName'],
            _itemsConclutionFinish[i]['value'],
          ),
        );
        setState(() {
          newTxConclutionFinies.add(
            ConclutionFinish.withConclutionFinishId(
              _conclutionFinishId,
              _conclutionId,
              _itemsConclutionFinish[i]['activityName'],
              _itemsConclutionFinish[i]['value'],
            ),
          );
        });
      }
    }

    setState(() {
      _listConclutions.add(newTxConclution);
      _listConclutionFinies = newTxConclutionFinies;
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

  void _deleteCalculate(String conclutionId) async {
    await _responseConclution!.doDelete(conclutionId);
    await _responseCalculate!.doDelete(conclutionId);
    await _responseConclutionFinish!.doDelete(conclutionId);

    setState(() {
      _listConclutions
          .removeWhere((conclution) => conclution.conclutionId == conclutionId);
      _listConclutionFinies.removeWhere(
          (conclutionFinish) => conclutionFinish.conclutionId == conclutionId);
    });
  }

  getLists() async {
    print('screen_calculate:::getLists():::initial');
    await _responseActivity!.doListActivity(_category.categoryId);
    await _responseCriteria!.doListCriteria(_category.categoryId);
    await _responseConclution!.doListConclution(_category.categoryId);
    print(
        'screen_calculate:::getLists():::_listConclutions.length:::${_listConclutions.length}');
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
        'screen_calculate:::onSuccessDoInsertConclution:::conclution.conclutionId:::${conclution.conclutionId}');
    print(
        'screen_calculate:::onSuccessDoInsertConclution:::conclution.conclutionName:::${conclution.conclutionName}');
    // setState(() {
    //   _listConclutions.add(conclution);
    // });
  }

  @override
  void onSuccessDoInsertConclutionFinish(ConclutionFinish conclutionFinish) {
    print(
        'screen_calculate:::onSuccessDoInsertConclutionFinish:::${conclutionFinish.activityName}');
    // setState(() {
    //   _listConclutionFinies.add(conclutionFinish);
    // });
  }

  @override
  Future<void> onSuccessDoListConclution(List<Conclution> conclutions) async {
    print('screen_calculate:::onSuccessDoListConclution:::$conclutions');

    setState(() async {
      _listConclutions = conclutions;
      print(
          'screen_calculate:::getLists():::_listConclutions.length:::${_listConclutions.length}');
      for (var i = 0; i < _listConclutions.length; i++) {
        await _responseConclutionFinish!
            .doListConclutionFinish(_listConclutions[i].conclutionId);
      }
    });
  }

  @override
  void onSuccessDoListConclutionFinish(
      List<ConclutionFinish> conclutionFinies) {
    setState(() {
      _listConcFinies.add(conclutionFinies);
    });
  }
}
