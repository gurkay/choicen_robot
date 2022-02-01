import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/activity.dart';
import '../../models/calculate.dart';
import '../../models/category.dart';
import '../../models/conclution.dart';
import '../../models/conclution_finish.dart';
import '../../models/criteria.dart';
import '../../services/response/response_activity.dart';
import '../../services/response/response_calculate.dart';
import '../../services/response/response_conclution.dart';
import '../../services/response/response_conclution_finish.dart';
import '../../services/response/response_criteria.dart';
import '../../screens/calculate/components/calculate_list.dart';
import '../../screens/calculate/components/get_calculate.dart';
import '../../screens/calculate/components/new_calculate.dart';
import '../../screens/calculate/components/update_calculate.dart';

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
  List<Calculate> _listCalculate = [];
  List<Conclution> _listConclutions = [];
  List<ConclutionFinish> _listConclutionFinies = [];
  List<Activity> _listActivities = [];
  List<Criteria> _listCriterias = [];
  List<Map<String, dynamic>> _itemsConclutionFinish = [];
  Calculate _calculate = new Calculate(0, '0', 0, 0, 0);

  final List<TextEditingController> _listTextEditingController = [];
  List<double> _listEnteredAmount = [];

  void _addNewCalculate(List<double> txAmount) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String _conclutionId = DateTime.now().toString();

    var currentTime = DateTime.now().toString().substring(0, 16);
    String _conclutionName = _category.categoryName + ' ' + currentTime;
    String _conclutionDate = DateTime.now().toString();

    await _responseConclution!.doInsert(
      Conclution.withConclutionId(
        _conclutionId,
        _category.categoryId,
        _conclutionName,
        _conclutionDate,
      ),
    );

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
        _itemsConclutionFinish.add(
          {
            'activityName': _listActivities[i].activityName,
            'value': generalTotalUtilityValue[i],
          },
        );
      });
    }

    _itemsConclutionFinish.sort((a, b) => b['value'].compareTo(a['value']));
    for (var i = 0; i < generalTotalUtilityValue.length; i++) {
      if (_itemsConclutionFinish[i]['value'] > avarageTotalUtility) {
        String _conclutionFinishId = DateTime.now().toString();
        await _responseConclutionFinish!.doInsert(
          ConclutionFinish.withConclutionFinishId(
            _conclutionFinishId,
            _conclutionId,
            _itemsConclutionFinish[i]['activityName'],
            _itemsConclutionFinish[i]['value'],
          ),
        );

        var newTxConcFinies = ConclutionFinish.withConclutionFinishId(
          _conclutionFinishId,
          _conclutionId,
          _itemsConclutionFinish[i]['activityName'],
          _itemsConclutionFinish[i]['value'],
        );

        setState(() {
          _listConclutionFinies.add(newTxConcFinies);
        });
      }
    }

    setState(() {
      _listConclutions.add(newTxConclution);
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
      },
    );
  }

  void _addUpdateCalculate(
    List<double> txAmount,
    Conclution conclution,
    List<Calculate> listCalculate,
  ) async {
    await _responseConclution!.doUpdate(conclution);
    for (var i = 0; i < _listCalculate.length; i++) {
      print(
          'screen_calculate:::_addUpdateCalculate:::fiyat: ${_listCalculate[i].amount}');
    }

    for (int i = 0, _listCount = 0; i < _listActivities.length; i++) {
      for (int j = 0; j < _listCriterias.length; j++, _listCount++) {
        await _responseCalculate!.doUpdate(
          Calculate.withCalculateId(
            listCalculate[_listCount].calculateId,
            listCalculate[_listCount].userId,
            conclution.conclutionId,
            _listActivities[i].activityId,
            _listCriterias[j].criteriaId,
            txAmount[_listCount],
          ),
        );
      }
    }

    await _responseConclutionFinish!.doDelete(conclution.conclutionId);

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
    _itemsConclutionFinish.clear();
    for (var i = 0; i < generalTotalUtilityValue.length; i++) {
      setState(() {
        _itemsConclutionFinish.add(
          {
            'activityName': _listActivities[i].activityName,
            'value': generalTotalUtilityValue[i],
          },
        );
      });
    }

    _itemsConclutionFinish.sort((a, b) => b['value'].compareTo(a['value']));
    for (var i = 0; i < generalTotalUtilityValue.length; i++) {
      if (_itemsConclutionFinish[i]['value'] > avarageTotalUtility) {
        String _conclutionFinishId = DateTime.now().toString();
        await _responseConclutionFinish!.doInsert(
          ConclutionFinish.withConclutionFinishId(
            _conclutionFinishId,
            conclution.conclutionId,
            _itemsConclutionFinish[i]['activityName'],
            _itemsConclutionFinish[i]['value'],
          ),
        );
      }
    }
    getLists();
  }

  void _startUpdateCalculate(
    BuildContext context,
    Conclution _conclution,
  ) async {
    await _responseCalculate!.doListCalculate(_conclution.conclutionId);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: UpdateCalculate(
            updateTx: _addUpdateCalculate,
            conclution: _conclution,
            listCalculate: _listCalculate,
            listActivities: _listActivities,
            listCriterias: _listCriterias,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
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
    _listActivities.clear();
    _listCalculate.clear();
    _listConclutionFinies.clear();
    _listConclutions.clear();
    _listCriterias.clear();
    _listEnteredAmount.clear();
    _listTextEditingController.clear();
    await _responseActivity!.doListActivity(_category.categoryId);
    await _responseCriteria!.doListCriteria(_category.categoryId);
    await _responseConclution!.doListConclution(_category.categoryId);
    await _responseConclutionFinish!.doListConclutionFinishWitoutId();
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
              conclutions: _listConclutions,
              conclutionFinies: _listConclutionFinies,
              deleteCalculate: _deleteCalculate,
              startUpdateCalculate: _startUpdateCalculate,
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
    print('screen_calculate:::onErrorCalculate:::$error');
  }

  @override
  void onSuccessDoDeleteCalculate(int result) {
    // TODO: implement onSuccessDoDeleteCalculate
  }

  @override
  void onSuccessDoInsertCalculate(Calculate calculate) {
    print(
        'screen_calculate:::onSuccessDoInsertCalculate:::calculate.conclutionId${calculate.conclutionId}');
  }

  @override
  void onSuccessDoListCalculate(List<Calculate> calculate) {
    setState(() {
      _listCalculate = calculate;
    });

    print(
        'screen_calculate:::onSuccessDoListCalculate:::fiyat - 0: ${calculate[0].amount}');
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
  void onSuccessDoInsertConclution(Conclution conclution) {}

  @override
  void onSuccessDoInsertConclutionFinish(ConclutionFinish conclutionFinish) {}

  @override
  Future<void> onSuccessDoListConclution(List<Conclution> conclutions) async {
    setState(() {
      _listConclutions = conclutions;
    });
  }

  @override
  void onSuccessDoListConclutionFinish(
      List<ConclutionFinish> conclutionFinies) {}

  @override
  void onSuccessDoListConclutionFinishWitoutId(
      List<ConclutionFinish> conclutionFinies) {
    setState(() {
      _listConclutionFinies = conclutionFinies;
    });
  }

  @override
  void onSuccessDoUpdateConclution(int result) {
    print('screen_calculate:::onSuccessDoUpdateConclution:::$result');
  }

  @override
  void onSuccessDoUpdateCalculate(int result) {
    print('screen_calculate:::onSuccessDoUpdateCalculate:::$result');
  }
}
