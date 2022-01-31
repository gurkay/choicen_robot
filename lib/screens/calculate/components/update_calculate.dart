import 'package:flutter/material.dart';

import '../../../models/conclution.dart';
import '../../../models/calculate.dart';

class UpdateCalculate extends StatefulWidget {
  final Function updateTx;
  final Conclution conclution;
  final Calculate calculate;

  UpdateCalculate({
    required this.updateTx,
    required this.conclution,
    required this.calculate,
  });

  @override
  _UpdateCalculateState createState() => _UpdateCalculateState();
}

class _UpdateCalculateState extends State<UpdateCalculate> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
