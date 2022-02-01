import 'package:flutter/material.dart';

import '../../../models/activity.dart';
import '../../../models/criteria.dart';
import '../../../models/conclution.dart';
import '../../../models/calculate.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';

class UpdateCalculate extends StatefulWidget {
  final Function updateTx;
  final Conclution conclution;
  final List<Calculate> listCalculate;
  final List<Activity> listActivities;
  final List<Criteria> listCriterias;

  UpdateCalculate({
    required this.updateTx,
    required this.conclution,
    required this.listCalculate,
    required this.listActivities,
    required this.listCriterias,
  });

  @override
  _UpdateCalculateState createState() => _UpdateCalculateState();
}

class _UpdateCalculateState extends State<UpdateCalculate> {
  final List<TextEditingController> _listTextEditingController = [];
  final List<Widget> _listCardWidget = [];
  final List<double> _listEnteredAmount = [];
  void _submitData() {
    for (int i = 0, _listCount = 0; i < widget.listActivities.length; i++) {
      for (int j = 0; j < widget.listCriterias.length; j++, _listCount++) {
        if (_listTextEditingController[_listCount].text.isEmpty) {
          return;
        }
      }
    }

    for (int i = 0, _listCount = 0; i < widget.listActivities.length; i++) {
      for (int j = 0; j < widget.listCriterias.length; j++, _listCount++) {
        _listEnteredAmount
            .add(double.parse(_listTextEditingController[_listCount].text));
      }
    }

    widget.updateTx(_listEnteredAmount);
    Navigator.of(context).pop();
  }

  void getList() {
    for (int i = 0, _listCount = 0; i < widget.listActivities.length; i++) {
      for (int j = 0; j < widget.listCriterias.length; j++, _listCount++) {
        _listTextEditingController.add(
          TextEditingController(
            text: widget.listCalculate[_listCount].amount.toString(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.80,
      child: Container(
        child: ListView.builder(
          itemCount: widget.listActivities.length,
          itemBuilder: (ctx, index) {
            for (int i = 0, _listCount = 0;
                i < widget.listActivities.length;
                i++) {
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
                              widget.listActivities[i].activityName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (int j = 0;
                          j < widget.listCriterias.length;
                          j++, _listCount++)
                        RoundedInputField(
                          hintText: '${widget.listCriterias[j].criteriaName}',
                          controller: _listTextEditingController[_listCount],
                          onChanged: (_) => _submitData,
                          keyboardType: TextInputType.number,
                        ),
                      (_listCount !=
                              (widget.listActivities.length *
                                  widget.listCriterias.length))
                          ? const Text('')
                          : RoundedButton(
                              text: 'Ekle',
                              press: _submitData,
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
}
