import 'package:choicen_robot/models/category.dart';
import 'package:flutter/material.dart';

class ScreenCalculate extends StatefulWidget {
  static String routeName = '/screen_calculate';
  final Category category;

  ScreenCalculate({required this.category});

  @override
  State<ScreenCalculate> createState() => _ScreenCalculateState(category);
}

class _ScreenCalculateState extends State<ScreenCalculate> {
  Category _category;
  _ScreenCalculateState(this._category);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
