import 'package:choicen_robot/constants/constants.dart';
import 'package:choicen_robot/models/category.dart';
import 'package:choicen_robot/models/criteria.dart';
import 'package:choicen_robot/screens/criteria/components/criteria_list.dart';
import 'package:choicen_robot/screens/criteria/components/new_criteria.dart';
import 'package:choicen_robot/services/response/response_criteria.dart';
import 'package:flutter/material.dart';

class ScreenCriteria extends StatefulWidget {
  static String routeName = '/screen_criteria';
  final Category category;

  ScreenCriteria({required this.category});

  @override
  _ScreenCriteriaState createState() => _ScreenCriteriaState(category);
}

class _ScreenCriteriaState extends State<ScreenCriteria>
    implements CallBackCriteria {
  Category _category;
  ResponseCriteria? _responseCriteria;
  _ScreenCriteriaState(this._category) {
    _responseCriteria = ResponseCriteria(this);
  }

  List<Criteria> _categoryCriterias = [];
  Criteria _criteria = new Criteria(0, '', 1);

  void _addNewCriteria(String txCriteriaName, int cmbBigValuePerfect) async {
    await _responseCriteria!.doInsert(
        Criteria(_category.categoryId, txCriteriaName, cmbBigValuePerfect));
    getCriteriasList();
    final newTx = Criteria.withCriteriaId(
      _criteria.criteriaId,
      _category.categoryId,
      txCriteriaName,
      cmbBigValuePerfect,
    );

    setState(() {
      _categoryCriterias.add(newTx);
    });
  }

  void _startAddCriteria(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewCriteria(_addNewCriteria),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteCriteria(int id) async {
    await _responseCriteria!.doDelete(id);
    setState(() {
      _categoryCriterias.removeWhere((criteria) => criteria.criteriaId == id);
    });
  }

  getCriteriasList() async {
    await _responseCriteria!.doListCriteria(_category.categoryId);
  }

  @override
  void initState() {
    getCriteriasList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenCriteria),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CriteriaList(
              _categoryCriterias,
              _deleteCriteria,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onErrorCriteria(String error) {
    print('screen_criteria:::onErrorCriteria:::$error');
  }

  @override
  void onSuccessDoDeleteCriteria(int result) {
    print('screen_criteria:::onSuccessDoDeleteCriteria:::$result');
  }

  @override
  void onSuccessDoInsertCriteria(Criteria criteria) {
    setState(() {
      _criteria = criteria;
    });
  }

  @override
  void onSuccessDoListCriteria(List<Criteria> criterias) {
    setState(() {
      _categoryCriterias = criterias;
    });
  }
}
