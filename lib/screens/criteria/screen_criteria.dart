import 'package:choicen_robot/models/criteria.dart';
import 'package:flutter/material.dart';

class ScreenCriteria extends StatefulWidget {
  static String routeName = '/screen_criteria';
  final Criteria criteria;

  ScreenCriteria({required this.criteria});

  @override
  _ScreenCriteriaState createState() => _ScreenCriteriaState(criteria);
}

class _ScreenCriteriaState extends State<ScreenCriteria> {
  Criteria _criteria;
  _ScreenCriteriaState(this._criteria);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
